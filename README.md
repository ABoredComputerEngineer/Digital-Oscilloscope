# How to Run

* Requires `make`, `avr-gcc` and `avr-dude` for generating and flashing hex files
* Requires `numpy` and `matplotlib` for generating plots

### To Compile:
From project directory ( in the command line ), run:
```
make 
```
### To Flash:
* Make sure that the correct Arduino COM port is selected in the `Makefile`
From project directory ( in the command line ), run:
```
make flash
```

### To Generate Data for plot:
Once the program has been flashed and running, select the correct COM port for the USB-TTL
and run
```
python src/test.py > src/data
```
Hit `Ctrl-C` to stop execution once you think you have enough data and then run
```
python src/plot.py
```
