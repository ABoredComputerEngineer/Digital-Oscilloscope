import serial
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Button
from mpldatacursor import datacursor
from matplotlib.widgets import Slider
fig1 = plt.figure()
ax = fig1.add_subplot(111)
ax.set_xlabel( "Time" )
ax.set_ylabel( "Voltage (Volts)" )
ax.xaxis.set_ticks( np.arange(0, 50, 1.0 ))
ax.grid()
buttonAxis = plt.axes([0.9,0.0,0.1,0.075])
bcut = Button( buttonAxis, 'YES', color='red', hovercolor='green')

timerDurationSec = {
        '5':b'\x00',
        '10':b'\x01',
        }

ser = serial.Serial( port = 'COM10',
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


def display_data( data ):
    array = np.array( plotData )
    time = array[ :, 0]
    channel1 = array[ :, 1]
    channel2 = array[ :, 3]
    time[0] = 0
    timeAxis = np.cumsum(time)
    p1 =ax.plot( timeAxis[600], channel1[:600] )
    p2 =ax.plot( timeAxis[:600], channel2[:600] )
    ax.xaxis.set_ticks( np.arange(0, len(plotData), 500.0 ))
    start, end = ax.get_xlim()
    ax.axis([0,500,0,5] )
    ax.xaxis.set_ticks(np.arange(0, 500, 50))
    datacursor( p1 )
    datacursor( p2 )
    ax.grid()
    plt.show()


def update_figure( val ):
    pos = spos.val
    ax.axis([pos,pos+500,0,5] )
#    ax.xaxis.set_ticks( np.arange(0, len(plotData), 10.0 ))
    fig1.canvas.draw_idle()

def onClick( event ):
    plotData.clear()
    ax.clear()
    plt.show()
    data = ser.write( timerDurationSec['10'] )
    start_sample()
    display_data( plotData )

bcut.on_clicked( onClick )
sliderAxes = plt.axes([0.2, 0.01, 0.65, 0.03] )
spos = Slider(sliderAxes, 'Pos', 0, 1600.0)
spos.on_changed( update_figure )
plt.show()