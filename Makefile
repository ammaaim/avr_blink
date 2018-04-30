# usage:
# make build - compile all
# make clean - remove all output files
# make flash - programming flash memory
# make tty - connect trough minicom by UART
# make erase - clear chip flash memory
#


# project name = current dir name
NAME = $(shell basename $(CURDIR))

DEBIAN_TTY = /dev/ttyACM0
MACOS_TTY = /dev/tty.usbmodem1411


# set here your arduino tty
SERIAL = $(MACOS_TTY)


.PHONY: all install clean

SRC = $(NAME).c 
OBJS = $(NAME).o
TARGET = $(NAME)
CLEAN = *.o *.bin *.elf *.hex

CC = avr-gcc
OBJCOPY = avr-objcopy
MCU = atmega328p
CFLAGS = -mmcu=$(MCU) -Wall -g -Os -lm  -mcall-prologues  -I./lib
LDFLAGS = -mmcu=$(MCU) -Wall -g -Os
SYMBOLS = -DF_CPU=16000000UL



all: $(TARGET).c
	make build
	make flash
	make clean


$(TARGET).elf: $(NAME).c
	$(CC) $(CFLAGS) $(SYMBOLS) -c $(SRC)
	$(CC) $(LDFLAGS) -o $(TARGET).elf  $(OBJS) -lm

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary -R .eeprom -R .nwram $(TARGET).elf $(TARGET).bin

$(TARGET).hex: $(TARGET).bin
	$(OBJCOPY) -O ihex -R .eeprom -R .nwram  $(TARGET).elf $(TARGET).hex

build:
	make $(TARGET).hex

clean:
	rm -rf $(CLEAN)



# Serial console to target
TTY = $(SERIAL)
TTY_BAUD = 9600

tty:
	minicom -D$(TTY) -b$(TTY_BAUD)

BT = /dev/tty.HC-05-DevB
bt:
	minicom -D$(BT) -b$(TTY_BAUD)

# dude
DUDE_BAUD = 115200
DUDE_MCU = m328p
DUDE_PROGRAMMER = arduino
DUDE_SERIAL = $(SERIAL)

erase:
	#todo

flash:
	avrdude -p $(DUDE_MCU) -c $(DUDE_PROGRAMMER) -P $(DUDE_SERIAL) -b $(DUDE_BAUD) -U flash:w:$(TARGET).hex
