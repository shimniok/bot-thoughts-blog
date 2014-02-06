/*
 * main.c
 *
 * LED Eyes - run two blinking led "eyes" for hiding in bushes and such
 *
 * Connect 20mA LEDs to PB3, PB4 with series 330ohm resistor for each
 *
 * ATtiny13A, Fuses: low=0x7a, high=0xff
 *
 * Sets itself to run at 150kHz
 *
 *  *** *** WARNING *** ***
 *
 *  If clock speed is too low you will have trouble programming the chip.
 *  The solution is, use a programmer for which you can set the ISP clock
 *  frequency. For example, in AVR Studio 4, you can set the ISP Frequency
 *  for both JTAG ICE MkII and AVR Dragon, presumably others. I'm not 
 *  familiar with how to do this in AVR Studio 6. With avrdude, the -B
 *  and -i flags may be what you need.
 *
 *  *** *** WARNING *** ***
 *
 *  Created on: Oct 30, 2013
 *      Author: mes
 */


#define F_CPU 150000

#include <avr/wdt.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/delay.h>
#include <stdbool.h>

#define ON 1
#define OFF 0

#define LEFTEYE  PB3
#define RIGHTEYE PB4

// random number seed (will give same flicker sequence each time)
uint32_t lfsr=0xdeadbeef;
volatile uint8_t sleep_interval=0;

void init_blink();
void init_wdt();
//void disable_wdt();
void blink(uint8_t count);
void eyes(uint8_t status);
uint32_t rand();
void delay(uint16_t ms);
void sleep(uint8_t s);
void slow_clock();

int main() 
{
	uint8_t i;

	init_wdt();
	init_blink();
	slow_clock();

	while (1) {
		blink(3+(uint8_t)(rand()>>31)); // 3 + up to 3 blinks
		eyes(OFF);
		sleep(3+(uint8_t)(rand()>>30)); // 3 +  up to 7 seconds
	}
}



void init_blink()
{
	DDRB |= (1<<LEFTEYE)|(1<<RIGHTEYE);
	eyes(OFF);
}


void blink(uint8_t count)
{
	uint8_t i;

	for (i = 0; i < count; i++) {
		// off for 400ms
		eyes(OFF);
		delay(50+(uint8_t)(rand()>>24)); // 50 + up to 256ms
		// on for 3-4s
		eyes(ON);
		delay(1000+(uint16_t)(rand()>>20)); // 3000 + up to 4096ms
	}
}

void eyes(uint8_t status)
{
	if (status) {
		PORTB |= (1<<RIGHTEYE);
		delay(10+(uint8_t)(rand()>>27)); // delay between eyes 10 + up to 32
		PORTB |= (1<<LEFTEYE);
	} else {
		PORTB &= ~(1<<RIGHTEYE);
		delay(10+(uint8_t)(rand()>>27)); // delay between eyes 10 + up to 32
		PORTB &= ~(1<<LEFTEYE);
	}
}


uint32_t rand()
{
	// http://en.wikipedia.org/wiki/Linear_feedback_shift_register
	// Galois LFSR: taps: 32 31 29 1; characteristic polynomial: x^32 + x^31 + x^29 + x + 1 
	lfsr = (lfsr >> 1) ^ (-(lfsr & 1u) & 0xD0000001u);
	return lfsr;
}


void delay(uint16_t ms) {
	while(ms) {
		_delay_ms(1); // this function must be called with a compile-time CONST, otherwise it pulls in float-math (huge)
		ms--;
	}
}


// Puts MCU to sleep for specified number of seconds using
// WDT to wake every second and track number of seconds
void sleep(uint8_t s)
{
	uint8_t i;
	sleep_interval = 0;
	while (sleep_interval < s) {
		set_sleep_mode(SLEEP_MODE_PWR_DOWN);
		wdt_reset();
		sleep_mode();
	}
}


// Enable watchdog interrupt, set prescaling to 1 sec
void init_wdt()
{
	// Disable interrupts
	cli();
	// Start timed sequence
	// Set Watchdog Change Enable bit
	_WD_CONTROL_REG |= (1<<WDCE);
	// Set new prescaler (1 sec), unset reset enable
	// enable WDT interrupt
	_WD_CONTROL_REG = (1<<WDTIE)|(1<<WDP2)|(1<<WDP1);
	sei();
}


// Slow clock to 150kHz, assumes 9.6MHz internal osc with clkdiv disabled
void slow_clock()
{
	// 150kHz
	CLKPR = (1<<CLKPCE);
	CLKPR = (1<<CLKPS2)|(1<<CLKPS1); // scale = /64
}


ISR(WDT_vect)
{
	sleep_interval++;
	wdt_reset();
	// Re-enable WDT interrupt. Normally we wouldn't do that here,
	// But we're using this routine purely as a timeout; 
	// WDT is never used for reset
	_WD_CONTROL_REG |= (1<<WDTIE);		
	return;
}
