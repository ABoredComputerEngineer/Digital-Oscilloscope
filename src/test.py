import serial
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Button


timerDurationSec = {
        '5':b'\x00',
        '10':b'\x01',
        }
ser = serial.Serial( port = 'COM11',
        baudrate = 9600,
        parity = serial.PARITY_NONE,
        bytesize = serial.EIGHTBITS,
        stopbits = serial.STOPBITS_ONE,
        timeout = 1 )
if ser is None:
    print( "Unable to open Serial Port at COM6" )

plotData = [[0,0,0,0]] 
# TODO: Needs more optimization
def start_sample( ):
    while 1:
        recieved = ser.read( 6 )
        check_bits1 = int.from_bytes( recieved[2:3], "little" )
        check_bits2 = int.from_bytes( recieved[5:6], "little" )
        if check_bits1 & ( 1 << 0x7 ) and check_bits2 & ( 1 << 0x7 ):
            break
        time1 = int.from_bytes( recieved[ :1 ], "little" );
        time2 = int.from_bytes( recieved[ 3:4], "little" );
        val1 = int.from_bytes( recieved[1:3], "little" ) * 5/1024;
        val2 = int.from_bytes( recieved[4:], "little" ) * 5/1024;
        plotData.append( [time1, val1, time2, val2])
        print( [time1, val1, time2, val2])
    return

def onClick( event ):
    plotData.clear()
    data = ser.write( timerDurationSec['5'] )
    start_sample()
    print( len(plotData) )

array = np.array( plotData )
time = array[ :, 0]
channel1 = array[ :, 1]
channel2 = array[ :, 3]
time[0] = 0
timeAxis = np.cumsum(time)
y = np.arange( 0, 300 )
fig1 = plt.figure()
ax = fig1.add_subplot(111)
ax.plot( timeAxis[:300], channel1[:300] )
ax.plot( timeAxis[:300], channel2[:300] )
ax.set_xlabel( "Time" )
ax.set_ylabel( "Voltage (Volts)" )
ax.grid()

buttonAxis = plt.axes([0.9,0.0,0.1,0.075])
bcut = Button( buttonAxis, 'YES', color='red', hovercolor='green')
bcut.on_clicked( onClick )
#bnext = Button(axnext, 'Next')
#bnext.on_clicked(callback.next)
#bprev = Button(axprev, 'Previous')
#bprev.on_clicked(callback.prev)

plt.show()