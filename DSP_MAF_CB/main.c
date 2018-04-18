//---------------------------------------------------------------------------------
// Project: Filter a signal using MAF Filters
// Author: Franco Polo
// Date: April 2018
//
// Note: A circular buffer is implemented to save data and use block processing. An
//      ADC interrupt is simulated with Timer2A and the sample is taken from a signal
//      made of two sines in Octave. The new sample is saved in the CB and then the
//      filter task is posted, where a MAF are applied.
//
//----------------------------------------------------------------------------------


//----------------------------------------
// BIOS header files
//----------------------------------------
#include <xdc/std.h>                        //mandatory - have to include first, for BIOS types
#include <ti/sysbios/BIOS.h>                //mandatory - if you call APIs like BIOS_start()
#include <xdc/runtime/Log.h>                //needed for any Log_info() call
#include <xdc/cfg/global.h>                 //header file for statically defined objects/handles


//------------------------------------------
// TivaWare Header Files
//------------------------------------------
#include <stdint.h>
#include <stdbool.h>

#include "inc/hw_types.h"
#include "inc/hw_memmap.h"
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"
#include "inc/hw_ints.h"
#include "driverlib/interrupt.h"
#include "driverlib/timer.h"

//----------------------------------------
// Prototypes
//----------------------------------------
void hardware_init(void);
void filter(void);

//----------------------------------------
// Defines
//----------------------------------------
#define nc 8 // Number of filter coefficients

//---------------------------------------
// Global signals
//---------------------------------------

const float noisysine [51] = {-0.2675099,   0.1373860,  -0.3550683,  -0.0922972,   0.0477486,
                              1.2908656,  -0.4436795,   1.2109093,   0.8843162,   1.6127550,
                              1.2586889,   1.4176823,   2.1696553,   1.5595758,   0.7229912,
                              1.4283494,   0.6295962,   1.3898659,   0.3679964,   1.2186368,
                              0.9031877,   1.6275388,  -0.1101673,   0.7579835,  -0.7764705,
                              -0.2253687,  -0.3899353,  -0.0070775,  -0.3096986,  -0.1553032,
                              -0.3410388,  -1.3391247,  -0.8618178,  -1.6605683,  -1.6316006,
                              -0.9862890,  -0.9145708,  -1.8025820,  -0.2907881,  -1.4326011,
                              -1.3092994,  -1.2684249,  -0.9286705,  -0.7646860,  -0.4821794,
                              -0.5168354,   0.3926131,  -0.7146609,  -0.7508930,   0.4944248,
                              -0.5048410};

//---------------------------------------
// Global variables
//---------------------------------------
int k = 0, pointer = 0, sine_index = 0;
int output_index = 0;
float y, circular_buffer[nc];

//---------------------------------------------------------------------------
// main()
//---------------------------------------------------------------------------
void main(void)
{

    hardware_init();                            // init hardware via Xware
    //
    BIOS_start();

}


//---------------------------------------------------------------------------
// hardware_init()
//
// Clock and Timer2A setup
//---------------------------------------------------------------------------
void hardware_init(void)
{
    uint32_t ui32Period;

    //Set CPU Clock to 40MHz. 400MHz PLL/2 = 200 DIV 5 = 40MHz
    SysCtlClockSet(SYSCTL_SYSDIV_5|SYSCTL_USE_PLL|SYSCTL_XTAL_16MHZ|SYSCTL_OSC_MAIN);

    // Timer 2 setup code
    SysCtlPeripheralEnable(SYSCTL_PERIPH_TIMER2);           // enable Timer 2 periph clks
    TimerConfigure(TIMER2_BASE, TIMER_CFG_PERIODIC);        // cfg Timer 2 mode - periodic

    ui32Period = (SysCtlClockGet()/8000);                   // Sample period (1/8kHz)
    TimerLoadSet(TIMER2_BASE, TIMER_A, ui32Period);         // set Timer 2 period

    TimerIntEnable(TIMER2_BASE, TIMER_TIMA_TIMEOUT);        // enables Timer 2 to interrupt CPU

    TimerEnable(TIMER2_BASE, TIMER_A);                      // enable Timer 2

}


//---------------------------------------------------------------------------
// filter()
//
// Apply FIR Filters
//---------------------------------------------------------------------------
void filter(void)
{
    // Filter
    y = (circular_buffer[(pointer)%nc]+circular_buffer[(pointer+1)%nc]+circular_buffer[(pointer+2)%nc]
      +circular_buffer[(pointer+3)%nc]+circular_buffer[(pointer+4)%nc]+circular_buffer[(pointer+5)%nc]
                                                                                                                                                                        +circular_buffer[(pointer+6)%nc]+circular_buffer[(pointer+7)%nc])/8;
    // Increment CB's pointer
    pointer = (pointer+1)%nc;
}



//---------------------------------------------------------------------------
// Timer_ISR
//
// Timer2A interrupt handler on Tiva-C LaunchPad
//---------------------------------------------------------------------------
void Timer_ISR(void)
{
    TimerIntClear(TIMER2_BASE, TIMER_TIMA_TIMEOUT);
    // Insert the newest sample into an N-sample circular buffer
    // The oldest sample in the circular buffer is overwritten.
    circular_buffer[pointer] = noisysine[sine_index];
    // Increment sine index
    if(sine_index == 50) sine_index = 0;
    else sine_index++;
    // Post filter SWi
    Swi_post(FIRSwi);
}
