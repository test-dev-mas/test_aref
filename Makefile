CC = /home/dev/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-gcc
CC_OBJCOPY = /home/dev/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-objcopy
CC_SIZE = ~/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin/avr-size
CC_UPLOAD = /home/dev/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude
CONF = /home/dev/.arduino15/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf
CFLAGS = -Os -DF_CPU=16000000UL -mmcu=atmega2560

USBPORT = /dev/ttyUSB0

all: main.elf

main.elf: main.o adc.o uart.o
	$(CC) $(CFLAGS) main.o adc.o uart.o -o main.elf

%.o: %.c
	$(CC) $(CFLAGS) -c $^

main.hex: main.elf
	$(CC_OBJCOPY) -O ihex -R .eeprom -R .efuse -R .hfuse -R .lfuse$< $@
size: main.elf
	$(CC_SIZE) --mcu=atmega2560 --format=avr main.elf
# an Arduino Uno is used as the programmer
install.main: main.hex
	$(CC_UPLOAD) -v -V -C $(CONF) -D -p atmega2560 -c wiring -P $(USBPORT)  -b 115200 -U flash:w:$<

read:
	$(CC_UPLOAD) -v -V -C $(CONF) -D -p atmega2560 -c wiring -P $(USBPORT)  -b 115200

clean:
	rm *.o *.elf *.hex