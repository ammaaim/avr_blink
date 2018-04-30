# avr_blink
simplest blink example for avr atmega328p (arduino uno r3). Includes universal Makefile and script for toolchain installation 

for avr toolchain installation run
```shell
sudo ./install_toolchain.sh
```

for project compilation run
```shell
make build
```

Please set up your arduino board in the Makefile before you try to flash programming:
```Makefile
DEBIAN_TTY = /dev/ttyACM0
MACOS_TTY = /dev/tty.usbmodem1411


# (!) set here your arduino tty (!)
SERIAL = $(MACOS_TTY)
```


for programm writing to the flash
```shell
make flash
```

for directory cleaning
```shell
make clean
```

Or just run:
```shell
make
```
