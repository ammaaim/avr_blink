
#include <avr/io.h>
#include <util/delay.h>

#define HALF_PERIOD_MS	666


int main() {
	// Set pin #5 of port B as output
    DDRB = DDRB | (1 << PB5);
    
	while(1) {
        // led on
        PORTB = 0xff;
		_delay_ms(HALF_PERIOD_MS);
        
        // led off
        PORTB = 0x00;
		_delay_ms(HALF_PERIOD_MS);
	}
	
	return 0;
}
