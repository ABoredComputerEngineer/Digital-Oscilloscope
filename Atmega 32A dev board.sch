EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:Atmega 32A dev board-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ATMEGA32A-PU U1
U 1 1 5E21743C
P 5000 4700
F 0 "U1" H 4150 6580 50  0000 L BNN
F 1 "ATMEGA32A-PU" H 5450 2750 50  0000 L BNN
F 2 "modFiles:DIP-40" H 5000 4700 50  0001 C CIN
F 3 "" H 5000 4700 50  0001 C CNN
	1    5000 4700
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x08_Female J1
U 1 1 5E21747B
P 6750 3300
F 0 "J1" H 6750 3700 50  0000 C CNN
F 1 "PORT A" V 6850 3300 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x08_Pitch2.54mm" H 6750 3300 50  0001 C CNN
F 3 "" H 6750 3300 50  0001 C CNN
	1    6750 3300
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x08_Female J2
U 1 1 5E2174CA
P 6750 4200
F 0 "J2" H 6750 4600 50  0000 C CNN
F 1 "PORT B" V 6850 4250 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x08_Pitch2.54mm" H 6750 4200 50  0001 C CNN
F 3 "" H 6750 4200 50  0001 C CNN
	1    6750 4200
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x08_Female J3
U 1 1 5E217511
P 6750 5100
F 0 "J3" H 6750 5500 50  0000 C CNN
F 1 "PORT C" V 6850 5050 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x08_Pitch2.54mm" H 6750 5100 50  0001 C CNN
F 3 "" H 6750 5100 50  0001 C CNN
	1    6750 5100
	1    0    0    -1  
$EndComp
$Comp
L L7805 U2
U 1 1 5E21D1EE
P 2750 1200
F 0 "U2" H 2600 1325 50  0000 C CNN
F 1 "L7805" H 2750 1325 50  0000 L CNN
F 2 "modFiles:Voltage_Regulators" H 2775 1050 50  0001 L CIN
F 3 "" H 2750 1150 50  0001 C CNN
	1    2750 1200
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5E21D381
P 2200 1650
F 0 "C1" H 2225 1750 50  0000 L CNN
F 1 "100uF" H 1900 1750 50  0000 L CNN
F 2 "modFiles:Capacitor_100uF" H 2238 1500 50  0001 C CNN
F 3 "" H 2200 1650 50  0001 C CNN
	1    2200 1650
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 5E21D3E2
P 3150 1650
F 0 "C2" H 3175 1750 50  0000 L CNN
F 1 "0.1uF" H 3175 1550 50  0000 L CNN
F 2 "modFiles:Capacitor_Disc_Small" H 3188 1500 50  0001 C CNN
F 3 "" H 3150 1650 50  0001 C CNN
	1    3150 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5E21D487
P 2750 2000
F 0 "#PWR01" H 2750 1750 50  0001 C CNN
F 1 "GND" H 2750 1850 50  0000 C CNN
F 2 "" H 2750 2000 50  0001 C CNN
F 3 "" H 2750 2000 50  0001 C CNN
	1    2750 2000
	1    0    0    -1  
$EndComp
$Comp
L LED D2
U 1 1 5E21D583
P 4100 1800
F 0 "D2" H 4100 1900 50  0000 C CNN
F 1 "LED" H 4100 1700 50  0000 C CNN
F 2 "modFiles:LED_D3.0mm" H 4100 1800 50  0001 C CNN
F 3 "" H 4100 1800 50  0001 C CNN
	1    4100 1800
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5E21D641
P 4350 1550
F 0 "R2" V 4430 1550 50  0000 C CNN
F 1 "470" V 4350 1550 50  0000 C CNN
F 2 "modFiles:Resistor_small" V 4280 1550 50  0001 C CNN
F 3 "" H 4350 1550 50  0001 C CNN
	1    4350 1550
	-1   0    0    1   
$EndComp
Text Label 4950 1200 0    60   ~ 0
VCC
Text Label 4850 2500 0    60   ~ 0
VCC
$Comp
L Crystal 16MHz1
U 1 1 5E21DDC1
P 6600 1600
F 0 "16MHz1" H 6600 1750 50  0000 C CNN
F 1 "Crystal" H 6600 1450 50  0000 C CNN
F 2 "modFiles:Crystal" H 6600 1600 50  0001 C CNN
F 3 "" H 6600 1600 50  0001 C CNN
	1    6600 1600
	0    1    1    0   
$EndComp
$Comp
L C C5
U 1 1 5E21DE84
P 5950 1400
F 0 "C5" H 5975 1500 50  0000 L CNN
F 1 "22pF" H 5975 1300 50  0000 L CNN
F 2 "modFiles:Capacitor_Disc_Medium" H 5988 1250 50  0001 C CNN
F 3 "" H 5950 1400 50  0001 C CNN
	1    5950 1400
	0    1    1    0   
$EndComp
$Comp
L C C6
U 1 1 5E21DEDF
P 5950 1850
F 0 "C6" H 5975 1950 50  0000 L CNN
F 1 "22pF" H 5975 1750 50  0000 L CNN
F 2 "modFiles:Capacitor_Disc_Medium" H 5988 1700 50  0001 C CNN
F 3 "" H 5950 1850 50  0001 C CNN
	1    5950 1850
	0    1    1    0   
$EndComp
$Comp
L GND #PWR02
U 1 1 5E21E037
P 5600 1750
F 0 "#PWR02" H 5600 1500 50  0001 C CNN
F 1 "GND" H 5600 1600 50  0000 C CNN
F 2 "" H 5600 1750 50  0001 C CNN
F 3 "" H 5600 1750 50  0001 C CNN
	1    5600 1750
	1    0    0    -1  
$EndComp
$Comp
L SW_DIP_x01 SW1
U 1 1 5E21E0E7
P 3550 1200
F 0 "SW1" H 3550 1350 50  0000 C CNN
F 1 "Power On/Off" H 3550 1050 50  0000 C CNN
F 2 "modFiles:DIP_Switch" H 3550 1200 50  0001 C CNN
F 3 "" H 3550 1200 50  0001 C CNN
	1    3550 1200
	1    0    0    -1  
$EndComp
Text Label 7000 1400 0    60   ~ 0
XTAL1
Text Label 7000 1850 0    60   ~ 0
XTAL2
Text Label 3800 3400 2    60   ~ 0
XTAL2
Text Label 3800 3800 2    60   ~ 0
XTAL1
$Comp
L SW_Push SW2
U 1 1 5E21EA47
P 4150 2350
F 0 "SW2" H 4200 2450 50  0000 L CNN
F 1 "Reset" H 4150 2250 50  0000 C CNN
F 2 "modFiles:Push_Button" H 4150 2550 50  0001 C CNN
F 3 "" H 4150 2550 50  0001 C CNN
	1    4150 2350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x02 J6
U 1 1 5E21F51C
P 3250 4500
F 0 "J6" H 3250 4600 50  0000 C CNN
F 1 "Short Ckt Aref" H 3250 4300 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 3250 4500 50  0001 C CNN
F 3 "" H 3250 4500 50  0001 C CNN
	1    3250 4500
	-1   0    0    1   
$EndComp
$Comp
L D D1
U 1 1 5E21F97B
P 1650 1200
F 0 "D1" H 1650 1300 50  0000 C CNN
F 1 "1N4004" H 1550 1100 50  0000 C CNN
F 2 "modFiles:Diode_Medium" H 1650 1200 50  0001 C CNN
F 3 "" H 1650 1200 50  0001 C CNN
	1    1650 1200
	-1   0    0    1   
$EndComp
$Comp
L R R1
U 1 1 5E2204F4
P 3550 3000
F 0 "R1" V 3630 3000 50  0000 C CNN
F 1 "1K" V 3550 3000 50  0000 C CNN
F 2 "modFiles:Resistor_small" V 3480 3000 50  0001 C CNN
F 3 "" H 3550 3000 50  0001 C CNN
	1    3550 3000
	0    1    1    0   
$EndComp
$Comp
L GND #PWR03
U 1 1 5E2209E1
P 4500 2450
F 0 "#PWR03" H 4500 2200 50  0001 C CNN
F 1 "GND" H 4500 2300 50  0000 C CNN
F 2 "" H 4500 2450 50  0001 C CNN
F 3 "" H 4500 2450 50  0001 C CNN
	1    4500 2450
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 5E220A7D
P 4150 2000
F 0 "C4" H 4175 2100 50  0000 L CNN
F 1 "1uF" H 4175 1900 50  0000 L CNN
F 2 "modFiles:Capacitor_Disc_Small" H 4188 1850 50  0001 C CNN
F 3 "" H 4150 2000 50  0001 C CNN
	1    4150 2000
	0    1    1    0   
$EndComp
$Comp
L C C3
U 1 1 5E220ECE
P 3850 4800
F 0 "C3" H 3875 4900 50  0000 L CNN
F 1 "0.1uF" H 3875 4700 50  0000 L CNN
F 2 "modFiles:Capacitor_Disc_Small" H 3888 4650 50  0001 C CNN
F 3 "" H 3850 4800 50  0001 C CNN
	1    3850 4800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 5E220FDE
P 3850 5150
F 0 "#PWR04" H 3850 4900 50  0001 C CNN
F 1 "GND" H 3850 5000 50  0000 C CNN
F 2 "" H 3850 5150 50  0001 C CNN
F 3 "" H 3850 5150 50  0001 C CNN
	1    3850 5150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 5E2218BD
P 4950 6850
F 0 "#PWR05" H 4950 6600 50  0001 C CNN
F 1 "GND" H 4950 6700 50  0000 C CNN
F 2 "" H 4950 6850 50  0001 C CNN
F 3 "" H 4950 6850 50  0001 C CNN
	1    4950 6850
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x06 J7
U 1 1 5E22279A
P 7600 4650
F 0 "J7" H 7600 4950 50  0000 C CNN
F 1 "PROGRAMMING PORTS" H 7700 4150 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x06_Pitch2.54mm" H 7600 4650 50  0001 C CNN
F 3 "" H 7600 4650 50  0001 C CNN
	1    7600 4650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5E222C5C
P 7200 4950
F 0 "#PWR06" H 7200 4700 50  0001 C CNN
F 1 "GND" H 7200 4800 50  0000 C CNN
F 2 "" H 7200 4950 50  0001 C CNN
F 3 "" H 7200 4950 50  0001 C CNN
	1    7200 4950
	1    0    0    -1  
$EndComp
Text Notes 7750 5000 0    60   ~ 0
RESET\nMOSI\nMISO\nSCK\nGND\nNo Connection
$Comp
L R R3
U 1 1 5E2259C4
P 9750 5400
F 0 "R3" V 9830 5400 50  0000 C CNN
F 1 "470" V 9750 5400 50  0000 C CNN
F 2 "modFiles:Resistor_small" V 9680 5400 50  0001 C CNN
F 3 "" H 9750 5400 50  0001 C CNN
	1    9750 5400
	0    1    1    0   
$EndComp
$Comp
L LED D4
U 1 1 5E225B4B
P 10200 5400
F 0 "D4" H 10200 5500 50  0000 C CNN
F 1 "LED" H 10200 5300 50  0000 C CNN
F 2 "modFiles:LED_D3.0mm" H 10200 5400 50  0001 C CNN
F 3 "" H 10200 5400 50  0001 C CNN
	1    10200 5400
	-1   0    0    1   
$EndComp
$Comp
L SW_DIP_x01 SW3
U 1 1 5E225C0E
P 9100 5100
F 0 "SW3" H 9100 5250 50  0000 C CNN
F 1 "SW_DIP_x01" H 9100 4950 50  0000 C CNN
F 2 "modFiles:DIP_Switch" H 9100 5100 50  0001 C CNN
F 3 "" H 9100 5100 50  0001 C CNN
	1    9100 5100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5E2267D4
P 10500 5550
F 0 "#PWR07" H 10500 5300 50  0001 C CNN
F 1 "GND" H 10500 5400 50  0000 C CNN
F 2 "" H 10500 5550 50  0001 C CNN
F 3 "" H 10500 5550 50  0001 C CNN
	1    10500 5550
	1    0    0    -1  
$EndComp
$Comp
L D D3
U 1 1 5E226C71
P 9600 4600
F 0 "D3" H 9600 4700 50  0000 C CNN
F 1 "D" H 9600 4500 50  0000 C CNN
F 2 "modFiles:Diode_Medium" H 9600 4600 50  0001 C CNN
F 3 "" H 9600 4600 50  0001 C CNN
	1    9600 4600
	0    1    1    0   
$EndComp
Text Label 9600 4200 0    60   ~ 0
VCC
$Comp
L Conn_01x06 J8
U 1 1 5E2286CB
P 7900 5800
F 0 "J8" H 7900 6100 50  0000 C CNN
F 1 "TO USB-TTL" H 7900 5400 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x06_Pitch2.54mm" H 7900 5800 50  0001 C CNN
F 3 "" H 7900 5800 50  0001 C CNN
	1    7900 5800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5E228D71
P 7500 6200
F 0 "#PWR08" H 7500 5950 50  0001 C CNN
F 1 "GND" H 7500 6050 50  0000 C CNN
F 2 "" H 7500 6200 50  0001 C CNN
F 3 "" H 7500 6200 50  0001 C CNN
	1    7500 6200
	1    0    0    -1  
$EndComp
Text Notes 8050 6150 0    60   ~ 0
5V\nVCC\n3V3\nTXD\nRXD\nGND
Wire Wire Line
	6000 6300 6650 6300
Wire Wire Line
	6000 6200 6650 6200
Wire Wire Line
	6000 6100 6650 6100
Wire Wire Line
	6000 6000 6650 6000
Wire Wire Line
	6000 5900 6650 5900
Wire Wire Line
	6000 5800 6650 5800
Wire Wire Line
	6000 5700 6650 5700
Wire Wire Line
	6000 5500 6550 5500
Wire Wire Line
	6000 5400 6550 5400
Wire Wire Line
	6000 5300 6550 5300
Wire Wire Line
	6000 5200 6550 5200
Wire Wire Line
	6000 5100 6550 5100
Wire Wire Line
	6000 5000 6550 5000
Wire Wire Line
	6000 4900 6550 4900
Wire Wire Line
	6550 4800 6000 4800
Wire Wire Line
	6000 4600 6550 4600
Wire Wire Line
	6000 4500 6550 4500
Wire Wire Line
	6000 4400 6550 4400
Wire Wire Line
	6000 4300 6550 4300
Wire Wire Line
	6000 4200 6550 4200
Wire Wire Line
	6000 4100 6550 4100
Wire Wire Line
	6000 4000 6550 4000
Wire Wire Line
	6000 3900 6550 3900
Wire Wire Line
	6000 3700 6550 3700
Wire Wire Line
	6000 3600 6550 3600
Wire Wire Line
	6000 3500 6550 3500
Wire Wire Line
	6000 3400 6550 3400
Wire Wire Line
	6550 3300 6000 3300
Wire Wire Line
	6000 3200 6550 3200
Wire Wire Line
	6550 3100 6000 3100
Wire Wire Line
	6000 3000 6550 3000
Wire Wire Line
	3150 1200 3150 1500
Wire Wire Line
	2750 2000 2750 1500
Connection ~ 2750 1800
Connection ~ 3150 1800
Connection ~ 3150 1200
Connection ~ 2200 1800
Wire Wire Line
	4850 2700 4850 2500
Wire Wire Line
	6100 1400 7000 1400
Wire Wire Line
	6600 1400 6600 1450
Wire Wire Line
	6100 1850 7000 1850
Wire Wire Line
	6600 1850 6600 1750
Wire Wire Line
	5800 1850 5800 1400
Wire Wire Line
	5600 1750 5600 1650
Wire Wire Line
	5600 1650 5800 1650
Connection ~ 5800 1650
Wire Wire Line
	3050 1200 3250 1200
Connection ~ 6600 1400
Connection ~ 6600 1850
Wire Wire Line
	3800 3400 4000 3400
Wire Wire Line
	3800 3800 4000 3800
Wire Wire Line
	3600 4500 3450 4500
Wire Wire Line
	3600 4200 3600 4500
Wire Wire Line
	3600 4400 3450 4400
Wire Wire Line
	3600 4200 4000 4200
Connection ~ 3600 4400
Wire Wire Line
	1350 1200 1500 1200
Wire Wire Line
	1350 1000 1550 1000
Wire Wire Line
	1550 1000 1550 1800
Wire Wire Line
	1800 1200 2450 1200
Wire Wire Line
	2200 1500 2200 1200
Connection ~ 2200 1200
Wire Wire Line
	3700 3000 4000 3000
Wire Wire Line
	3400 3000 3100 3000
Wire Wire Line
	3100 3000 3100 2650
Wire Wire Line
	3100 2650 4850 2650
Connection ~ 4850 2650
Wire Wire Line
	3850 2000 3850 3000
Wire Wire Line
	3850 2350 3950 2350
Connection ~ 3850 3000
Wire Wire Line
	4350 2350 4500 2350
Wire Wire Line
	4500 2000 4500 2450
Wire Wire Line
	3850 2000 4000 2000
Connection ~ 3850 2350
Wire Wire Line
	4300 2000 7400 2000
Connection ~ 4500 2350
Wire Wire Line
	3850 4650 3850 4200
Connection ~ 3850 4200
Wire Wire Line
	3850 5150 3850 4950
Wire Wire Line
	4950 6850 4950 6700
Wire Wire Line
	7400 2000 7400 4450
Connection ~ 4500 2000
Wire Wire Line
	7400 4550 6300 4550
Wire Wire Line
	6300 4550 6300 4400
Connection ~ 6300 4400
Wire Wire Line
	7400 4650 6350 4650
Wire Wire Line
	6350 4650 6350 4500
Connection ~ 6350 4500
Wire Wire Line
	7400 4750 6300 4750
Wire Wire Line
	6300 4750 6300 4600
Connection ~ 6300 4600
Wire Wire Line
	7200 4950 7200 4850
Wire Wire Line
	7200 4850 7400 4850
Wire Wire Line
	1550 1800 3950 1800
Wire Wire Line
	4250 1800 4350 1800
Wire Wire Line
	4350 1800 4350 1700
Wire Wire Line
	3850 1200 4950 1200
Wire Wire Line
	4350 1200 4350 1400
Connection ~ 4350 1200
Wire Wire Line
	9900 5400 10050 5400
Wire Wire Line
	10350 5400 10500 5400
Wire Wire Line
	10500 5400 10500 5550
Wire Wire Line
	9600 4750 9600 5400
Wire Wire Line
	9600 5100 9400 5100
Connection ~ 9600 5100
Wire Wire Line
	9600 4450 9600 4200
Wire Wire Line
	7700 5600 7700 5350
Wire Wire Line
	7700 5350 8800 5350
Wire Wire Line
	8800 5350 8800 5100
Connection ~ 6450 5800
Connection ~ 6450 5700
Wire Wire Line
	7700 5900 6900 5900
Wire Wire Line
	6900 5900 6900 5750
Wire Wire Line
	6900 5750 6450 5750
Wire Wire Line
	6450 5750 6450 5800
Wire Wire Line
	6450 5700 6450 5600
Wire Wire Line
	6450 5600 7550 5600
Wire Wire Line
	7550 5600 7550 6000
Wire Wire Line
	7550 6000 7700 6000
Wire Wire Line
	7500 6200 7500 6100
Wire Wire Line
	7500 6100 7700 6100
$Comp
L L L1
U 1 1 5E229DCD
P 5150 2450
F 0 "L1" V 5100 2450 50  0000 C CNN
F 1 "10uH" V 5225 2450 50  0000 C CNN
F 2 "modFiles:Resistor_small" H 5150 2450 50  0001 C CNN
F 3 "" H 5150 2450 50  0001 C CNN
	1    5150 2450
	-1   0    0    1   
$EndComp
Wire Wire Line
	5150 2700 5150 2600
Text Label 5150 2200 0    60   ~ 0
VCC
Wire Wire Line
	5150 2300 5150 2200
$Comp
L C C7
U 1 1 5E22A54B
P 5500 2700
F 0 "C7" H 5525 2800 50  0000 L CNN
F 1 "100nF" H 5400 2900 50  0000 L CNN
F 2 "modFiles:Capacitor_Disc_Small" H 5538 2550 50  0001 C CNN
F 3 "" H 5500 2700 50  0001 C CNN
	1    5500 2700
	0    1    1    0   
$EndComp
Wire Wire Line
	5150 2650 5350 2650
Wire Wire Line
	5350 2650 5350 2700
Connection ~ 5150 2650
$Comp
L GND #PWR09
U 1 1 5E22A6C1
P 6000 2650
F 0 "#PWR09" H 6000 2400 50  0001 C CNN
F 1 "GND" H 6000 2500 50  0000 C CNN
F 2 "" H 6000 2650 50  0001 C CNN
F 3 "" H 6000 2650 50  0001 C CNN
	1    6000 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 2700 5650 2550
Wire Wire Line
	5650 2550 6000 2550
Wire Wire Line
	6000 2550 6000 2650
$Comp
L Conn_01x02 J5
U 1 1 5E22B5CD
P 1000 1150
F 0 "J5" H 1000 1250 50  0000 C CNN
F 1 "INPUT" H 1000 950 50  0000 C CNN
F 2 "modFiles:Connector_Bornier_2" H 1000 1150 50  0001 C CNN
F 3 "" H 1000 1150 50  0001 C CNN
	1    1000 1150
	-1   0    0    1   
$EndComp
Wire Wire Line
	1200 1050 1350 1050
Wire Wire Line
	1350 1050 1350 1000
Wire Wire Line
	1200 1150 1350 1150
Wire Wire Line
	1350 1150 1350 1200
Text Notes 6900 3700 0    60   ~ 0
PA0\nPA1\nPA2\nPA3\nPA4\nPA5\nPA6\nPA7
Text Notes 6900 4600 0    60   ~ 0
PB0\nPB1\nPB2\nPB3\nPB4\nPB5\nPB6\nPB7
Text Notes 6900 5500 0    60   ~ 0
PC0\nPC1\nPC2\nPC3\nPC4\nPC5\nPC6\nPC7
Text Notes 6900 6400 0    60   ~ 0
PD0\nPD1\nPD2\nPD3\nPD4\nPD5\nPD6\nPD7
$Comp
L Conn_01x07 J9
U 1 1 5E22CC53
P 6850 6000
F 0 "J9" H 6850 6400 50  0000 C CNN
F 1 "PORT D" H 6850 5600 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x07_Pitch2.54mm" H 6850 6000 50  0001 C CNN
F 3 "" H 6850 6000 50  0001 C CNN
	1    6850 6000
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J4
U 1 1 5E22D136
P 6250 6400
F 0 "J4" H 6250 6500 50  0000 C CNN
F 1 "PD7" H 6250 6300 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x01_Pitch2.54mm" H 6250 6400 50  0001 C CNN
F 3 "" H 6250 6400 50  0001 C CNN
	1    6250 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 6400 6050 6400
Wire Wire Line
	5050 6700 5050 6800
Wire Wire Line
	5050 6800 4950 6800
Connection ~ 4950 6800
$EndSCHEMATC
