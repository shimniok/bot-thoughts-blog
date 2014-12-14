#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

/**
 * Turntable Strobe driver for ATtiny25 family
 * 
 * @author: Michael Shimniok - www.bot-thoughts.com
 * @created: 3/11/2014
 * @description: Drives a turntable strobe LED at 50Hz or 60Hz and runs a simple
 *              charge pump voltage doubler for the LED strobe. For the LED, use a
 * 				timer with overflow interrupt and increment a counter variable.
 * 				Toggle the LED output pin every INTERVAL interrupts. In the main
 * 				loop, run the charge pump with 50% duty cycle pulses approximately
 * 				every 1 usec. I realize there are other ways to do all this and this
 * 				is what I chose for now. :)
 */

// I should probably put one of these on OC1A ...
// but it's not like the microcontroller has much else to do.
#define LED  PB2 
#define PUMP PB0
#define ONTIME 40
#define MATCH 200		// 12MHz/4/200 = 15000
#ifndef PERIOD
#error No PERIOD defined, use -DPERIOD=?
#endif

int main() {
	DDRB |= (1<<LED)|(1<<PB1);
	PORTB &= ~(1<<LED); 

	TCCR1 |= (1<<PWM1A)|			// Clear timer on compare match
			 (1<<CTC1)|				// PWM using OCR1A to count and OCR1C to match;
			 (1<<CS11)|(1<<CS10);	// Run timer at PCK/4 = 12Mhz/4 = 3MHz;
	OCR1C = MATCH-1;				// To get N counts, set OCR1C to N-1
	TIMSK |= (1<<TOIE1);			// Enable interrupt on timer overflow
	sei();
	
	// Run the charge pump, timing doesn't have to be super accurate
	DDRB |= (1<<PUMP);
	while (1) {
		PINB |= (1<<PUMP); // Toggle charge pump line
		_delay_us(1);
	}
}

ISR(TIM1_OVF_vect) {
	static unsigned int count = 0;
	count++;

	if (count >= PERIOD) {
		count = 0;
	} else if (count > ONTIME) {
		PORTB |= (1<<LED);
	} else {
		PORTB &= ~(1<<LED); // Toggle LED line
	}

}
