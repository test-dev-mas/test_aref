#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <avr/wdt.h>
#include <util/delay.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "adc.h"
// #include "sd.h"
// #include "spi.h"
// #include "timers.h"
#include "uart.h"

/*  modes (taken from sleep.h) 
    #define SLEEP_MODE_IDLE         0
    #define SLEEP_MODE_PWR_DOWN     1
    #define SLEEP_MODE_PWR_SAVE     2
    #define SLEEP_MODE_ADC          3
    #define SLEEP_MODE_STANDBY      4
    #define SLEEP_MODE_EXT_STANDBY  5
*/

int main() {
    init_adc();
    uart0_init();
    
    set_sleep_mode(SLEEP_MODE_PWR_DOWN);
    sei();

    for(;;) {
        sleep_mode();
    }
}

// ISR(TIMER0_COMPA_vect) {
//     sys_tick++;
// }