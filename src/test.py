import serial
timerDurationSec = {
        '5':b'\x00',
        '10':b'\x01',
        };
ser = serial.Serial( port = 'COM6',
        baudrate = 9600 * 2,
        parity = serial.PARITY_NONE,
        bytesize = serial.EIGHTBITS,
        stopbits = serial.STOPBITS_ONE,
        timeout = 1 )
if ser is None:
    print( "Unable to open Serial Port at COM6" )

data = ser.write( timerDurationSec['10'] )

# TODO: Needs more optimization
while 1:
    recieved = ser.read( 6 )
    #print( str( int.from_bytes( recieved[:1], "little" ) )  + "," + 
    #        str( int.from_bytes( recieved[3:4],"little" ) ) )
    check_bits1 = int.from_bytes( recieved[2:3], "little" )
    check_bits2 = int.from_bytes( recieved[5:6], "little" )
    if check_bits1 & ( 1 << 0x7 ) and check_bits2 & ( 1 << 0x7 ):
        break;
    
    time1 = int.from_bytes( recieved[ :1 ], "little" );
    time2 = int.from_bytes( recieved[ 3:4], "little" );
    val1 = int.from_bytes( recieved[1:3], "little" );
    val2 = int.from_bytes( recieved[4:], "little" );
    print( str( time1 ) + "," +  str(val1) + "," + str(time2) +  "," + str(val2) )

