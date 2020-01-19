#define CLOCK_FREQUENCY
#define SANITY_CHECK 1

#ifndef F_CPU
  #define F_CPU 1000000
#endif

#include <avr/io.h>
#include <util/delay.h>
#include "setbaud.h"

typedef unsigned int uint;
typedef uint16_t u16;
typedef uint8_t u8;
typedef uint32_t u32;

static char Message[] = "Hello World!";

static u8 data_to_send[4];
#define MESSAGE_LEN 12
#define BAUD_RATE_9600 0x6

#define WRITE_UBBRH( x ) ( UBBRH = ( x ) )
#define WRITE_USCRC( x ) ( USCRC = ( 1<<URSEL ) | ( x ) )

#define SET_BIT( src, bit ) ( ( src ) |= ( 1 << ( bit ) ) )
#define RESET_BIT( src, bit ) ( ( src ) &= ~(1 << ( bit ) ) )

#define ADC_CONVERSION_COMPLETE ( ADCSRA & ( 1 << ADIF ) )

#define ADC_ENABLE_BIT ADEN
enum ADC_Inputs {
  ADC_INPUT_0 = 0x0,
  ADC_INPUT_1 = 0x1
};

enum ADC_Refs {
  ADC_AREF = 0x0,
  ADC_AVCC = 0x1,
  ADC_INTERNAL = 0x3
};

enum ADC_Prescaler {
  ADC_PS_2 = 0x0,
  ADC_PS_4 = 0x2,
  ADC_PS_8 = 0x3,
  ADC_PS_16 = 0X4,
  ADC_PS_32 = 0x5,
  ADC_PS_64 = 0x6,
  ADC_PS_128 = 0x7
};

void USART_init( u16 baud ){
 // Set the baud rate
  //UBRRH = ( u8 )( baud >> 8 );
  //UBRRL = baud & 0xff;
  setBaud( 9600, 1.0e6 );
  // Enable reciever and transmitter
  UCSRB = ( 1 << RXEN ) | ( 1 << TXEN );

  // Set the frame format: 8-bit data ( USCZ0 ), 1 stop bits
  // Asynchronous operation
  //UCSRC = ( 1 << URSEL ) | ( 0 << USBS ) | ( 0x3 << UCSZ0 );

  // 8-bit per frame with no parity, 1 stop bit
  UCSRC = ( 1 << URSEL ) | ( 0 << USBS ) | ( 0x3 << UCSZ0 );

}


void USART_Transmit( u8 data ){
  // Wait until all the remaining data has been transmitted
  while ( !(UCSRA&(1<<UDRE) ) );

  // Send the data by storing it in UDR Register
  UDR = data;
}

void USART_Transmit_Buffer( u8 *buff, u8 len ){
  for ( u8 i = 0; i < len; i++ ){
    USART_Transmit( *( buff + i )  ); 
  }
}


u8 USART_Receive( void ){
  // Wait for data to be received fully
  PORTD |= ( 1 << PD6 );
  while ( !( UCSRA & ( 1 << RXC ) ) );
  PORTD &= ~( 1 << PD6 );
  return UDR; 
}

void ADC_init( u8 prescaler ){
  // Enable the ADC
  ADCSRA |= ( 1 << ADC_ENABLE_BIT ) | ( prescaler & 0x7 );
  ADMUX = ( ADC_AVCC << REFS0 );

}

void ADC_disable( ){
  RESET_BIT( ADCSRA, ADC_ENABLE_BIT );
}


// eg. ADC_INPUT_1
//
u16 ADC_GetData( u8 input_pin ){
#if SANITY_CHECK
  ADMUX |= ( input_pin & 0x1f );
#else
  ADMUX |= input_pin
#endif

  SET_BIT( ADCSRA, ADSC );

  // TODO: Maybe not block and use interrupts 
  // block until the conversion completes
  while ( !ADC_CONVERSION_COMPLETE );

  // This step is mandatory
  u8 lower = ADCL;
#if SANITY_CHECK
  u16 higher = ADCH;
  u16 result = ( ( higher & 0x3f ) << 8 ) |  lower;
  return result;
#else
  return ( ( (u16)ADCH & 0x3f ) << 8 ) | lower;
#endif
}

int main(void){
  DDRD |= ( 1 << PD6 )|(1<<PD4);
  USART_init( 6 );  
  ADC_init( ADC_PS_8 ); 
  // Wait for the host to send something first
  USART_Receive();
  for ( ; ; ){
    PORTD ^= ( 1 << PD4 );
    // Receive data from analog pins ( ADC Conversion )
    // This is not inside a function because it
    // and prevents using unecessary 16-bit ( or even 32-bit )
    // arithmetic
    // ( TODO ): Try to use 24-bit ( 3 bytes ) for sending
    // Currently uses 32-bits ( 4bytes, 16-bit for each
    // channel )

    // Select pin 0 for input 
      ADMUX |= ( ADC_INPUT_0  );
      // Start conversion 
      SET_BIT( ADCSRA, ADSC );

      // TODO: *Maybe* not block and use interrupts ?
      // block until the conversion completes
      while ( !ADC_CONVERSION_COMPLETE );
      // This step is mandatory
      data_to_send[0] = ADCL;
      data_to_send[1] = ADCH & 0x3;
      // Deselect pin 0
      ADMUX &= ~(ADC_INPUT_0 );

//      _delay_ms( 1 );
      ADMUX |= ( ADC_INPUT_1  );
      // Start conversion 
      SET_BIT( ADCSRA, ADSC );

      // TODO: *Maybe* not block and use interrupts ?
      // block until the conversion completes
      while ( !ADC_CONVERSION_COMPLETE );
      // This step is mandatory
      data_to_send[2] = ADCL;
      data_to_send[3] = ADCH & 0x3;
      USART_Transmit_Buffer( data_to_send, sizeof( data_to_send ) );
      ADMUX &= ~( ADC_INPUT_1 );
    // Acknowledgement sent from the host
//    USART_Receive();
//    _delay_ms( 500 );
  }
  return 0;
}
