import serial
ser = serial.Serial( port = 'COM6',
        baudrate = 9600,
        parity = serial.PARITY_NONE,
        bytesize = serial.EIGHTBITS,
        stopbits = serial.STOPBITS_ONE,
        timeout = 1 )
if ser is None:
    print( "Unable to open Serial Port at COM6" )

data = ser.write( b'\x01' )

# TODO: Needs more optimization
while 1:
    recieved = ser.read( 4 )
    ch1 = recieved[ :2];
    ch2 = recieved[2: ];
    val1 = int.from_bytes( ch1 ,"little" ) * 5 / 1024
    val2 = int.from_bytes( ch2 ,"little" ) * 5 / 1024
    print( str(val1) + "," + str(val2) )
