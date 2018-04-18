//---------------------------------------------------------------------------------
// Project: Filter a signal using FIR Filters
// Author: Franco Polo
// Date: April 2018
//
// Note: A circular buffer is implemented to save data and use block processing. An
//      ADC interrupt is simulated with Timer2A and the sample is taken from a signal
//      made of two sines in Octave. The new sample is saved in the CB and then the
//      filter task is posted, where LPF and HPF FIR filters are applied.
//
//----------------------------------------------------------------------------------


//----------------------------------------
// BIOS header files
//----------------------------------------
#include <xdc/std.h>  						//mandatory - have to include first, for BIOS types
#include <ti/sysbios/BIOS.h> 				//mandatory - if you call APIs like BIOS_start()
#include <xdc/runtime/Log.h>				//needed for any Log_info() call
#include <xdc/cfg/global.h> 				//header file for statically defined objects/handles


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
// Defines
//----------------------------------------
#define nc 8 // Number of filter coefficients

//----------------------------------------
// Prototypes
//----------------------------------------
void hardware_init(void);
void filter(void);

//---------------------------------------
// Global signals
//---------------------------------------

// 100Hz and 800Hz sines
// fs = 5000Hz
// Ts = 200uS
const float sines[50] = { 0.00000,   0.96966,   1.15352,   0.49346,  -0.28876,
                          -0.36327,   0.43586,   1.45506,   1.82662,   1.27295,
                          0.36327,  -0.01574,   0.51627,   1.47978,   1.98031,
                          1.53884,   0.53670,  -0.13796,   0.08597,   0.93324,
                          1.53884,   1.25227,   0.24279,  -0.65614,  -0.71899,
                          0.00000,   0.71899,   0.65614,  -0.24279,  -1.25227,
                          -1.53884,  -0.93324,  -0.08597,   0.13796,  -0.53670,
                          -1.53884,  -1.98031,  -1.47978,  -0.51627,   0.01574,
                          -0.36327,  -1.27295,  -1.82662,  -1.45506,  -0.43586,
                          0.36327,   0.28876,  -0.49346,  -1.15352,  -0.96966};

// LPF
// FIR coefficients wc = 0.1pi = 250Hz @ fs = 5000Hz
// Rectangular window - 20dB attenuation
const float hlpf[8] = {0.0810332,  0.09003163,  0.09633978,  0.09958927,
                       0.09958927, 0.09633978,  0.09003163,  0.0810332};

// HPF
// FIR coefficients wc = 0.2pi = 500Hz @ fs = 5000Hz
// Rectangular window - 20db attenuation
const float hhpf[8] = {0.0735766,  -0.12732395,  0.17167874, -0.19672633,
                       0.19672633, -0.17167874,  0.12732395, -0.0735766};

//---------------------------------------
// Global variables
//---------------------------------------
int k = 0, pointer = 0, sine_index = 0;
int output_index = 0;
float y[50], y2[50], circular_buffer[nc];

//---------------------------------------------------------------------------
// main()
//---------------------------------------------------------------------------
void main(void)
{

    hardware_init();							// init hardware via Xware

    BIOS_start();

}


//---------------------------------------------------------------------------
// hardware_init()
//
// inits GPIO pins for toggling the LED
//---------------------------------------------------------------------------
void hardware_init(void)
{
    uint32_t ui32Period;

    //Set CPU Clock to 40MHz. 400MHz PLL/2 = 200 DIV 5 = 40MHz
    SysCtlClockSet(SYSCTL_SYSDIV_5|SYSCTL_USE_PLL|SYSCTL_XTAL_16MHZ|SYSCTL_OSC_MAIN);

    // Timer 2 setup code
    SysCtlPeripheralEnable(SYSCTL_PERIPH_TIMER2);			// enable Timer 2 periph clks
    TimerConfigure(TIMER2_BASE, TIMER_CFG_PERIODIC);		// cfg Timer 2 mode - periodic

    ui32Period = (SysCtlClockGet()/8000);                   // Sample period (1/8kHz)
    TimerLoadSet(TIMER2_BASE, TIMER_A, ui32Period);			// set Timer 2 period

    TimerIntEnable(TIMER2_BASE, TIMER_TIMA_TIMEOUT);		// enables Timer 2 to interrupt CPU

    TimerEnable(TIMER2_BASE, TIMER_A);						// enable Timer 2

}


//---------------------------------------------------------------------------
// ledToggle()
//
// toggles LED on Tiva-C LaunchPad
//---------------------------------------------------------------------------
void filter(void)
{
    // Filter
    y[output_index] = 0;
    for(k=0;k < nc; k++){
        y[output_index] += hlpf[k]*circular_buffer[(pointer+k)%nc];
        y2[output_index] += hhpf[k]*circular_buffer[(pointer+k)%nc];
    }
    // Increment CB's pointer
    pointer = (pointer+1)%nc;
    // Increment Output index
    if(output_index == 49) output_index = 0;
    else output_index++;
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
    circular_buffer[pointer] = sines[sine_index];
    // Increment sine index
    if(sine_index == 49) sine_index = 0;
    else sine_index++;
    // Post filter SWi
    Swi_post(FIRSwi);
}
