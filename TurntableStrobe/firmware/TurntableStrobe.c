#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

/**
 * Turntable Strobe driver for ATtiny25 family
 * 
 * @author: Michael Shimniok - www.bot-thoughts.com
 * @created: 3/11/2014
 * @description: Drives a turntable strobe LED at 60Hz and runs a simple charge 
 *               pump voltage doubler for the LED strobe. For the LED, use a timer
 *               with overflow interrupt and increment a counter variable. Toggle
 *               the LED output pin every INTERVAL interrupts. In the main loop,
 *               run the charge pump with 50% duty cycle pulses approximately every
 *               1usec. I realize there are other ways to do all this and this is
 *               what I chose for now. :)
 */

// 
// But it's not like the microcontroller has much else to do.

// I should probably put one of these on OC1A ...
#define LED  PB2 
#define PUMP PB0
#define ONTIME 60
#define PERIOD 249

int main() {
	DDRB |= (1<<LED)|(1<<PB1);
	PORTB &= ~(1<<LED); 

	TCCR1 |= (1<<PWM1A)|(1<<CTC1)|(1<<CS11)|(1<<CS10); // 4MHz
	OCR1C = 199;
	TIMSK |= (1<<TOIE1);
	sei();
	
	// Run the charge pump, timing doesn't have to be super accurate
	DDRB |= (1<<PUMP);
	while (1) {
		PINB |= (1<<PUMP); // Toggle charge pump line
		_delay_us(1);
	}
}

ISR(TIM1_OVF_vect) {
	static unsigned char count = 0;
	count++;

	if (count > PERIOD) {
		count = 0;
	} else if (count > ONTIME) {
		PORTB |= (1<<LED);
	} else {
		PORTB &= ~(1<<LED); // Toggle LED line
	}

}
