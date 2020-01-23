import matplotlib.pyplot as plt
import numpy as np

dataCount = 100

file = np.genfromtxt( './data', delimiter=',' )
#time1 = file[:,0]
#time2 = file[:,2]
val1 = file[:,0]
val2 = file[:,1]
y = np.arange( 0, 300 )
fig1 = plt.figure()
ax = fig1.add_subplot(111)
ax.plot( y, val1[:300] )
ax.plot( y, val2[:300] )
ax.set_xlabel( "Time" )
ax.set_ylabel( "Voltage (Volts)" )
ax.grid()

#bnext = Button(axnext, 'Next')
#bnext.on_clicked(callback.next)
#bprev = Button(axprev, 'Previous')
#bprev.on_clicked(callback.prev)

plt.show()

