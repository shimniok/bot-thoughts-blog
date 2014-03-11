#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// Turntable Strobe driver
// Drives a turntable strobe LED at 60Hz and also
// runs a simple charge pump voltage doubler for the LED strobe

// ATtiny25 family

// We programmatically keep track of overflow time. Yes, I know hardware can do this.
// But it's not like the microcontroller has much else to do.

// Assuming 12MHz clock
// need to divide by 200000 to get 60Hz
// 200000/64 = 3125

#define PERIOD 125
#define ONTIME 50

#define LED  PB2	// I should probably put one of these on OC1A ...
#define PUMP PB0

int main() {
	DDRB |= (1<<LED)|(1<<PB1);
	PORTB &= ~(1<<LED);
	TCCR1 |= (1<<CTC1)|(1<<COM1A0)|(1<<CS12)|(1<<CS11)|(1<<CS10); // /64
	OCR1C = 25;
	TIMSK |= (1<<OCIE1A);
	sei();
	
	// Run the charge pump, timing doesn't have to be super accurate
	DDRB |= (1<<PUMP);
	while (1) {
		PORTB |= (1<<PUMP);
		_delay_us(1);
		PORTB &= ~(1<<PUMP);
		_delay_us(1);
	}
}


ISR(TIM1_COMPA_vect) {
	static int count = 0;
	++count;
	if (count > 4) {
		count = 0;
		PINB |= (1<<LED);
	}
}
