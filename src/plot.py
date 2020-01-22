import matplotlib.pyplot as plt
import numpy as np

dataCount = 100

file = np.genfromtxt( './src/data', delimiter=',' )
ch1 = file[:,0]
ch2 = file[:,1]
y = np.arange( 0, 300 )
fig1 = plt.figure()
ax = fig1.add_subplot(111);
ax.plot( y, ch1[:300] )
ax.plot( y, ch2[:300] )
ax.set_xlabel( "Time" )
ax.set_ylabel( "Voltage (Volts)" )
ax.grid()


plt.show()
