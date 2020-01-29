import serial
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Button
from mpldatacursor import datacursor
from matplotlib.widgets import Slider
from scipy import interpolate
fig1 = plt.figure()
ax = fig1.add_subplot(111)
ax.set_xlabel( "Time",fontsize=18 )
ax.set_ylabel( "Voltage (Volts)",fontsize=18 )
ax.xaxis.set_ticks( np.arange(0, 50, 1.0 ))
ax.grid()
channel0_text = fig1.text(0.3, 0.9, 'Channel 0 peak-to-peak voltage: {} Volts'.format(100), style='italic', fontsize=14)
channel1_text = fig1.text(0.7, 0.9, 'Channel 1 peak-to-peak voltage: {} Volts'.format(100), style='italic', fontsize=14)
buttonAxis = plt.axes([0.9,0.0,0.1,0.075])
bcut = Button( buttonAxis, 'Sample', color='red', hovercolor='green')

ax.legend()
timerDurationSec = {
        '5':b'\x00',
        '10':b'\x01',
        }

ser = serial.Serial( port = 'COM10',
        baudrate = 9600,
        parity = serial.PARITY_NONE,
        bytesize = serial.EIGHTBITS,
        stopbits = serial.STOPBITS_ONE,
        timeout = 2 )
if ser is None:
    print( "Unable to open Serial Port at COM6" )

plotData = [[0,0,0,0]] 
# TODO: Needs more optimization
def start_sample( ):
    for i in range( 0, 600 ):
        recv = ser.read( 3 )
        #print( recv )
        y1 = int.from_bytes( recv[:1], "little" )
        y2 = int.from_bytes( recv[1:2], "little" )
        y3 = int.from_bytes( recv[2:], "little" )
        print( str(y1) + ","+str(y2)+","+str(y3))
        plotData.append( [y1,y2,y3] )
    return


def display_data( data ):
    array = np.array( data )
    time = array[ :, 0]
    channel2 = array[ :, 2] * 5/255
    channel1 = ( ( array[ :, 1] * 5/255 )-1.2)
    time[0] = 0
    timeAxis = np.cumsum(time)
    print( str(len(timeAxis)) + ", " + str( max(timeAxis)))
    p1 =ax.plot( timeAxis, channel1 )
    p2 =ax.plot( timeAxis, channel2 )
#    ax.xaxis.set_ticks( np.arange(0, len(plotData), 500.0 ))
    start, end = ax.get_xlim()
    ax.axis([0,max(timeAxis),0,5.5] )
    ax.xaxis.set_ticks(np.arange(0, max(timeAxis), 200))
    ax.set_xlabel( "Time (200 div =625ms)", fontsize = 18 )
    ax.set_ylabel( "Voltage (Volts)", fontsize=16 )
    datacursor( p1 )
    datacursor( p2 )
    ch0pp = max( channel1 ) - min(channel1)
    ch1pp = max( channel2 ) - min(channel2)
    channel0_text.set_text('Channel 0 peak-to-peak voltage: {} Volts'.format(ch0pp) )
    channel1_text.set_text('Channel 1 peak-to-peak voltage: {} Volts'.format(ch1pp) )
    ax.grid()
    plt.show()


def update_figure( val ):
    pos = spos.val
    ax.axis([pos,pos+1000,0,5.5] )
#    ax.xaxis.set_ticks( np.arange(0, len(plotData), 10.0 ))
    fig1.canvas.draw_idle()

def onClick( event ):
    plotData.clear()
    ax.clear()
    plt.show()
    data = ser.write( timerDurationSec['5'] )
    start_sample()
    display_data( plotData )

bcut.on_clicked( onClick )
sliderAxes = plt.axes([0.2, 0.01, 0.65, 0.03] )
spos = Slider(sliderAxes, 'Pos', 0, 3300.0)
spos.on_changed( update_figure )
plt.show()