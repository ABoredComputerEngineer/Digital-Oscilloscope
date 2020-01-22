import serial
timerDurationSec = {
        '5':b'\x00',
        '10':b'\x01',
        };
ser = serial.Serial( port = 'COM6',
        baudrate = 9600,
        parity = serial.PARITY_NONE,
        bytesize = serial.EIGHTBITS,
        stopbits = serial.STOPBITS_ONE,
        timeout = 1 )
if ser is None:
    print( "Unable to open Serial Port at COM6" )

data = ser.write( timerDurationSec['5'] )

# TODO: Needs more optimization
while 1:
    recieved = ser.read( 6 )
    check_bits1 = int.from_bytes( recieved[2:3], "little" )
    check_bits2 = int.from_bytes( recieved[5:6], "little" )
    if check_bits1 & ( 1 << 0x7 ) and check_bits2 & ( 1 << 0x7 ):
        break;

    ch1 = int.from_bytes( recieved [:3], "little" )
    ch2 = int.from_bytes( recieved [3:], "little" )
    
    time1 = ( ch1 >> 16 ) & 0xff
    val1 = ( ch1 & 0x3ff ) * 5 / 1024
    time2 = ( ch2 >> 16 ) & 0xff
    val2 = ( ch2 & 0x3ff ) * 5 / 1024

    print( str( time1 ) + "," +  str(val1) + "," + str(time2) +  "," + str(val2) )

