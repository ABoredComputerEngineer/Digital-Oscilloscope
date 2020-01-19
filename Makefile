# Name: Makefile
# Author: <insert your name here>
# Copyright: <insert your copyright message here>
# License: <insert your license reference here>

# DEVICE ....... The AVR device you compile for
# CLOCK ........ Target AVR clock rate in Hertz
# OBJECTS ...... The object files created from your source files. This list is
#                usually the same as the list of source files with suffix ".o".
# PROGRAMMER ... Options to avrdude which define the hardware you use for
#                uploading to the AVR and the interface where this hardware
#                is connected.
# FUSES ........ Parameters for avrdude to flash the fuses appropriately.

DEVICE     = atmega32
CLOCK      = 1000000
PROGRAMMER = -c arduino -P COM7 -b 19200 
FUSES      = -U lfuse:w:0xE1:m 	-U hfuse:w:0x99:m 	-U lock:w:0xFF:m
SRC = ./src
BIN = ./bin
OUTELF = $(BIN)/main.elf
OUTHEX = $(BIN)/main.hex
OBJECTS    = $(BIN)/main.o
######################################################################
######################################################################

# Tune the lines below only if you know what you are doing:

AVRDUDE = avrdude $(PROGRAMMER) -p $(DEVICE)
COMPILE = avr-gcc -Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)

# symbolic targets:
all:	$(OUTHEX)

$(BIN)/main.o: $(SRC)/main.c
	$(COMPILE) -c $< -o $@

.S.o:
	$(COMPILE) -x assembler-with-cpp -c $< -o $@
# "-x assembler-with-cpp" should not be necessary since this is the default
# file type for the .S (with capital S) extension. However, upper case
# characters are not always preserved on Windows. To ensure WinAVR
# compatibility define the file type manually.

.c.s:
	$(COMPILE) -S $< -o $@

flash:	all
	$(AVRDUDE) -U flash:w:$(OUTHEX):i

fuse:
	$(AVRDUDE) $(FUSES)

install: flash fuse

# if you use a bootloader, change the command below appropriately:
load: all
	bootloadHID $(OUTELF)

clean:
	rm -f $(OUTHEX) $(OUTELF) $(OBJECTS)

# file targets:
$(OUTELF): $(OBJECTS)
	$(COMPILE) -o $(OUTELF) $(OBJECTS) 

$(OUTHEX): $(OUTELF)
#	rm -f main.hex
	avr-objcopy -j .text -j .data -O ihex $(OUTELF) $(OUTHEX)
# If you have an EEPROM section, you must also create a hex file for the
# EEPROM and add it to the "flash" target.

# Targets for code debugging and analysis:
disasm:	$(OUTELF)
	avr-objdump -d $(OUTELF)

cpp:
	$(COMPILE) -E $(SRC)/main.c
