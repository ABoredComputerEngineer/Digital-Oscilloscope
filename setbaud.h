#ifndef _setbaud_h_
#define _setbaud_h_

/*
   Copyright (c) 2006
   Dipl.-Ing. Hans-Juergen Heinrichs
   33184 Altenbeken, Germany
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.

   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

   * Neither the name of the copyright holders nor the names of
     contributors may be used to endorse or promote products derived
     from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE.
*/

/* ------------------------------------------------------------------
 *
 *  v o i d   s e t B a u d ( BAUD, F )
 *
 *  Parameters:
 *  ===========
 *
 *      BAUD : any baudrate that is appropriate for the application
 *      F    : the processors clock frequency
 *
 *      BAUD as well as F need to be compile time constants!
 *
 *
 *  Description:
 *  ============
 *
 *      Given a desired baudrate (BAUD) and the processor clock frequency (F)
 *      setBaud() sets AVRs baudrate control registers to the correct values.
 *      If double speed option is available the setting with the smallest
 *      error rate will be chosen.
 *      !!! This include file requires gcc optimization level 1,2 or s !!!
 *      This is required to avoid floating point code.
 *
 *
 *  Example:
 *  ========
 *
 *      #include "setbaud.h"
 *      :
 *      :
 *      setBaud( 9600, 8.0e6 )
 *
 *
 *  Formulas:
 *  =========
 *
 *      For asynchronous normal  |   For asynchronous double
 *      mode (U2X = 0):          |   speed  (U2X = 1):
 *      ====================================================
 *               FOSC            |            FOSC
 *      UBRR =  ------   - 1     |   UBRR =  ------   - 1
 *              16*BAUD          |           8*BAUD
 *      ----------------------------------------------------
 *
 *               clossest_Baudrate
 *      Error =  -----------------  - 1
 *               desired_Baudrate
 *
 *
 * ------------------------------------------------------------------
 */

#ifdef U2X0
#   define _UCSRA UCSR0A
#   define _UBRRH UBRR0H
#   define _UBRRL UBRR0L
#   define _U2X   U2X0
#else
#   define _UCSRA UCSRA
#   define _UBRRH UBRRH
#   define _UBRRL UBRRL
#   define _U2X   U2X
#endif

static __inline__ void setBaud(double, double) __attribute__((always_inline));
static __inline__ void setBaud(double bd, double f)
{
    /* calculate the UBRR values (ATMEL spec.) */
    unsigned int ubrr_val     = f / (16.0 * bd) + 0.5 - 1;
    unsigned int ubrr_val_u2x = f / ( 8.0 * bd) + 0.5 - 1;

    /* recalculate resulting baudrate (ATMEL spec.) */
    double baud     = f / (16.0 * (ubrr_val    +1));
    double baud_u2x = f / ( 8.0 * (ubrr_val_u2x+1));

    /* calculate the absolute value of resulting error */
    double error     = (baud     / bd) - 1;
    double error_u2x = (baud_u2x / bd) - 1;
    if( error     < 0 ) error     *= -1.0;
    if( error_u2x < 0 ) error_u2x *= -1.0;

    if( error >= 0.02 && error_u2x >= 0.02 )  {
        /*
         * any idea how to create some kind
         * of compile time warning here is welcome
         */
    }

    /*
     * So far, no code has been generated - all of the
     * above calculations will be optimized away by the
     * gcc code generator.
     */
#ifdef _U2X
    /* Only choose U2X if error rating is better */
    if( error <= error_u2x )  {
        _UCSRA &= ~(1<<_U2X);
        _UBRRH = ubrr_val >> 8;
        _UBRRL = ubrr_val  & 0xFF;
    } else  {
        _UCSRA |= (1<<_U2X);
        _UBRRH = ubrr_val_u2x >> 8;
        _UBRRL = ubrr_val_u2x  & 0xFF;
    }
#else
    UBRR = ubrr_val;
#endif
}

#endif /* _setbaud_h_ */
