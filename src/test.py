import serial
import sys
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Button
from mpldatacursor import datacursor
from matplotlib.widgets import Slider
from matplotlib.widgets import RadioButtons
import time
from scipy import interpolate
from enum import Enum

ProgramState = Enum( 'ProgramState', 'slow fast' )
fig1 = plt.figure()
ax = fig1.add_subplot(111)
ax.set_xlabel( "Time",fontsize=18 )
ax.set_ylabel( "Voltage (Volts)",fontsize=18 )
ax.xaxis.set_ticks( np.arange(0, 50, 1.0 ))
ax.grid()
channel0_text = fig1.text(0.3, 0.9, 'Channel 0 peak-to-peak voltage: {} Volts'.format(100), style='italic', fontsize=14)
channel1_text = fig1.text(0.7, 0.9, 'Channel 1 peak-to-peak voltage: {} Volts'.format(100), style='italic', fontsize=14)
buttonAxis = plt.axes([0.9,0.0,0.1,0.075])
itBaxis= plt.axes( [0.9, 0.6, 0.1, 0.075])
incTimeAxisButton = Button( itBaxis, 'Increase', color='red', hovercolor='green')

dtBaxis= plt.axes( [0.9, 0.4, 0.1, 0.075])

decTimeAxisButton = Button( dtBaxis, 'Decrease', color='red', hovercolor='green')
sampleButton = Button( buttonAxis, 'Sample', color='red', hovercolor='green')

programSelectAxis = plt.axes( [ 0.9, 0.8, 0.1, 0.075 ] )
programSelectRadio = RadioButtons( programSelectAxis, ('LF', 'HF' ) )
program = ProgramState.slow

sliderAxes = plt.axes([0.2, 0.01, 0.65, 0.03] )
timeScaleLength = 100 # in milli seconds
timeScaleStep = 10 # in milli seconds
timerPreScaler = 128
ax.legend()

spos = Slider(sliderAxes, 'Pos', 0, 100.0)

timerDurationSec = {
        '5':b'\x00',
        '10':b'\x01',
        }
AdcState = {
        'Fast': b'\x00',
        'Slow': b'\x01'
        }

ProgramSpeedDict = { 
        'LF': ProgramState.slow,
        'HF': ProgramState.fast
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
channel1 = []
channel2 = []
timeAxis = []

def update_figure( val ):
    pos = spos.val
    ax.axis([pos,pos+timeScaleLength,0,5.5] )
    ax.xaxis.set_ticks(np.arange(pos, pos + timeScaleLength, timeScaleLength/10))
#    ax.xaxis.set_ticks( np.arange(0, len(plotData), 10.0 ))
    fig1.canvas.draw_idle()

def read_data_fast():
    global plotData
    ser.write( b'\x01\x01' )
    for i in range( 0, 600 ):
        recv = ser.read( 3 )
        y1 = int.from_bytes( recv[:1], "little" )
        y2 = int.from_bytes( recv[1:2], "little" ) * 5/255
        y3 = int.from_bytes( recv[2:], "little" ) * 5/255
        print( str(y1) + ","+str(y2)+","+str(y3))
        plotData.append( [y1,y2,y3] )
    return

def read_data_slow():
    global plotData
    ser.write( b'\x00\x00' )
    while 1:
        recieved = ser.read( 6 )
        check_bits1 = int.from_bytes( recieved[2:3], "little" )
        check_bits2 = int.from_bytes( recieved[5:6], "little" )
        if check_bits1 & ( 1 << 0x7 ) and check_bits2 & ( 1 << 0x7 ):
            print("Ending Recieve data")
          #  ser.read( 6 )
            break
        time1 = int.from_bytes( recieved[ :1 ], "little" )
        time2 = int.from_bytes( recieved[ 3:4], "little" )
        val1 = int.from_bytes( recieved[1:3], "little" ) * 5/1024
        val2 = int.from_bytes( recieved[4:], "little" ) * 5/1024
        plotData.append( [time1, val1,val2])
        print( [time1, val1,val2])
    return

def start_sample( state ):
    global plotData 
    global channel1 
    global channel2 
    global timeAxis 
    global timerPreScaler
    if ( state == ProgramState.fast ): 
        read_data_fast()
    elif ( state == ProgramState.slow ):
        read_data_slow()
    else :
        print("Unkown program state")
        sys.exit()
    array = np.array( plotData )
    time = array[ :, 0]
    channel2 = array[ :, 2] 
    channel1 = array[ :, 1]
    timeAxis = ( np.cumsum(time) * timerPreScaler ) / ( 1000 ) # in milli seconds
    print( "timer prescaler = " + str( timerPreScaler))
    return


def display_data( data ):
    global timeAxis
    global spos
    global sliderAxes
    print( str(len(timeAxis)) + ", " + str( max(timeAxis)))
    p1 =ax.plot( timeAxis, channel1 )
    p2 =ax.plot( timeAxis, channel2 )
    start, end = ax.get_xlim()
    ax.axis([0,max(timeAxis),0,5.5] )
    ax.xaxis.set_ticks(np.arange(0, max(timeAxis), max(timeAxis) / 10 ))
    ax.set_xlabel( "Time (micro seconds)", fontsize = 18 )
    ax.set_ylabel( "Voltage (Volts)", fontsize=16 )
    datacursor( p1 )
    datacursor( p2 )
    ch0pp = max( channel1 ) - min(channel1)
    ch1pp = max( channel2 ) - min(channel2)
    channel0_text.set_text('Channel 0 peak-to-peak voltage: {} Volts'.format(ch0pp) )
    channel1_text.set_text('Channel 1 peak-to-peak voltage: {} Volts'.format(ch1pp) )
    ax.grid()
    spos = Slider(sliderAxes, 'Pos', 0, max(timeAxis) )
    spos.on_changed( update_figure )
    plt.show()
    return



def onTimeIncrease( event ):
    global timeScaleLength
    pos = spos.val
    if ( timeScaleLength - timeScaleStep > 0 ):
        timeScaleLength = timeScaleLength - timeScaleStep 
    ax.axis( [pos,pos+timeScaleLength, 0, 5.5 ]) 
    ax.xaxis.set_ticks(np.arange(pos, pos + timeScaleLength, timeScaleLength/10))
    fig1.canvas.draw_idle()
    return

def onTimeDecrease( event ):
    global timeScaleLength
    pos = spos.val
    if ( timeScaleLength + timeScaleStep < 1000 ):
        timeScaleLength = timeScaleLength +timeScaleStep 
    ax.axis( [pos,pos+timeScaleLength, 0, 5.5 ]) 
    ax.xaxis.set_ticks(np.arange(pos, pos + timeScaleLength, timeScaleLength/10))
    fig1.canvas.draw_idle()
    return

def onSample( event ):
    global plotData
    global ax
    global sliderAxes
    global program
    plotData.clear()
    ax.clear()
    #sliderAxes.clear()
    start_sample(program)
    display_data( plotData )
    return

def onRadioClick( label ):
    global program
    global ProgramSpeedDict
    global timerPreScaler
    program = ProgramSpeedDict[label]
    if ( program == ProgramState.slow ):
        timerPreScaler = 128
    elif ( program == ProgramState.fast ):
        timerPreScaler = 1
    return

sampleButton.on_clicked( onSample )
incTimeAxisButton.on_clicked( onTimeIncrease )
decTimeAxisButton.on_clicked( onTimeDecrease )
spos.on_changed( update_figure )
programSelectRadio.on_clicked( onRadioClick )
plt.show()
