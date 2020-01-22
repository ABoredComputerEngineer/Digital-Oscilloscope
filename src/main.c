#define CLOCK_FREQUENCY
#define SANITY_CHECK 1

#ifndef F_CPU
  #define F_CPU 1000000
#endif

#include <avr/io.h>
#include <util/delay.h>
#include "setbaud.h"
#include <avr/interrupt.h>
#include <stdbool.h>

typedef unsigned int uint;
typedef uint16_t u16;
typedef uint8_t u8;
typedef uint32_t u32;

static u8 data_to_send[4 * 25]; // Send data in bursts of 100 bytes
static u8 data_len = 100;
#define BAUD_RATE 9600

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

enum Timer_Prescaler {
  TIMER_PS_NONE = 0x0,
  TIMER_PS_1 = 0x1,
  TIMER_PS_8 = 0x2,
  TIMER_PS_64 = 0x3,
  TIMER_PS_256= 0x4,
  TIMER_PS_1024 = 0x5,
  TIMER_PS_EXTERNAL_FALL = 0x6,
  TIMER_PS_EXTERNAL_RISE = 0x7,
};

typedef enum Program_State{
  STATE_INACTIVE,
  STATE_ADC_CONVERSION,
  STATE_TRANSMISSION
} Program_State;

volatile Program_State Global_State;
volatile u8 End_Of_Conversion;

static u8 Timer_Duration[] = {
  0x4c, 0x4a, // 5sec with 1MHz, PS =256 
  0x98, 0x95, // 10sec with 1MHz, PS =256 
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

void Timer1_Init( u8 ps, u8 high, u8 low ){
  // toggle OCA1 on compare match
  // CTC Mode, Sets WGM 11 and WGM 10
  TCCR1A = ( 0x1 << COM1A0 );
  TCCR1B |= ( 0x1 << WGM12 ); // Sets  WGM13 and WGM12
  TCCR1B |= ps; 
  TIMSK |= ( 0x1 << OCIE1A );
  // The order is important!!
  OCR1AH = high;
  OCR1AL = low;
}

void Timer2_Init( u8 ps ){
  // Normal Mode
  TCCR2 |= ( ps & 0x7 );
}


ISR(TIMER1_COMPA_vect){
  PORTD |= (1<<PD6);
  Global_State = STATE_INACTIVE;
  End_Of_Conversion = true;
}


static inline void Timer1_Reset( void ){
  SFIOR &= ~(1<<PSR10); // Reset the timer
}

static inline void Timer2_Reset( void ){
  SFIOR &= ~(1<<PSR2);
}

int main(void){
  //cli();
  DDRD |= (1<<PD7)|(1<<PD6)|(1<<PD5)|(1<<PD4) ;
  USART_init( 6 );  
  ADC_init( ADC_PS_8 ); 
  Global_State = STATE_INACTIVE;
  // Wait for the host to send something first
  u8 user_input;
  sei();
  for ( ; ; ){
    switch ( Global_State ) {
      case STATE_ADC_CONVERSION:
//        PORTD ^= ( 1 << PD4 );
        ADMUX |= ( ADC_INPUT_0  );
        SET_BIT( ADCSRA, ADSC );
        u8 time = TCNT2;
        while ( !ADC_CONVERSION_COMPLETE );
        data_to_send[0] = time;
        data_to_send[1] = ADCL;
        data_to_send[2] = ADCH & 0x3;
        ADMUX &= ~(ADC_INPUT_0 );

        ADMUX |= ( ADC_INPUT_1  );
        SET_BIT( ADCSRA, ADSC );
        time = TCNT2;
        Timer2_Reset();
        while ( !ADC_CONVERSION_COMPLETE );
        data_to_send[3] = time;
        data_to_send[4] = ADCL;
        data_to_send[5] = ADCH & 0x3;

        USART_Transmit_Buffer( data_to_send, 6 );
        ADMUX &= ~( ADC_INPUT_1 );
        break;
      case STATE_INACTIVE:
        if ( End_Of_Conversion ){
          for ( int i = 0; i < 6 ; i++ ){
            USART_Transmit( 1 << 0x7 );
          }
        }

        cli();
        SET_BIT( PORTD, PD6 ); 
        RESET_BIT( PORTD, PD4 );
        user_input = USART_Receive();
        sei();

        Timer2_Init( TIMER_PS_1024 );
        if ( user_input == 0x0 ) {
          Timer1_Init( TIMER_PS_256,
              Timer_Duration[0],
              Timer_Duration[1] );
        } else {
          Timer1_Init( TIMER_PS_256,
              Timer_Duration[2],
              Timer_Duration[3] );
        }

        Global_State = STATE_ADC_CONVERSION;
        RESET_BIT( PORTD, PD6 );
        Timer1_Reset();
        Timer2_Reset();
        break;
      default:
        break;
    }
  }
  return 0;
}
