#!/bin/sh

PROJECT  = TurntableStrobe

C_SRCS   = $(PROJECT).c 
#OBJS     = $(PROJECT).o crt1.o
OBJS     = $(PROJECT).o
LIBS = 
LIBDIRS  = 
INCLUDES = 
LSS          = $(PROJECT).lss
FLASH_IMAGE  = $(PROJECT).hex
EEPROM_IMAGE = $(PROJECT).eep
SIZEDUMMY = sizedummy

F_CPU    = 12000000UL
MCU      = attiny85
CFLAGS   = -Wall -Os -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$(MCU) -DF_CPU=$(F_CPU) -ffunction-sections
LDFLAGS  = $(LIBDIRS) $(LIBS) -lm -Wl,-gc-sections

TARGET=t85
#AVR Dragon
PORT=usb
PROGRAMMER=dragon_isp
#Pololu programmer
#PORT=/dev/pololu_avrisp
#PROGRAMMER=avrispv2
#JTAG ICE MkII
#PORT=usb
#PROGRAMMER=jtag2isp
#AVRDUDE_FLAGS=-F


# Add inputs and outputs from these tool invocations to the build variables 

RM := rm -rf

# All Target
all: $(PROJECT).elf secondary-outputs

# This is included for AVR Studio 4 compatibility
$(PROJECT): all

# Tool invocations
$(PROJECT).elf: $(OBJS) $(LIBS)
	@echo 'Building target: $@'
	@echo 'Invoking: AVR C Linker'
	avr-gcc -Wl,-Map,$(PROJECT).map $(LIBDIRS) -mmcu=$(MCU) -o "$(PROJECT).elf" $(OBJS) $(LDFLAGS)
	@echo 'Finished building target: $@'
	@echo ' '

$(PROJECT).lss: $(PROJECT).elf
	@echo 'Invoking: AVR Create Extended Listing'
	-avr-objdump -h -S $(PROJECT).elf  >"$(PROJECT).lss"
	@echo 'Finished building: $@'
	@echo ' '

$(PROJECT).hex: $(PROJECT).elf
	@echo 'Create Flash image (ihex format)'
	-avr-objcopy -R .eeprom -O ihex $(PROJECT).elf  "$(PROJECT).hex"
	@echo 'Finished building: $@'
	@echo ' '

$(PROJECT).eep: $(PROJECT).elf
	@echo 'Create eeprom image (ihex format)'
	-avr-objcopy -j .eeprom --no-change-warnings --change-section-lma .eeprom=0 -O ihex $(PROJECT).elf  "$(PROJECT).eep"
	@echo 'Finished building: $@'
	@echo ' '

sizedummy: $(PROJECT).elf
	@echo 'Invoking: Print Size'
	-avr-size --format=berkeley -t $(PROJECT).elf
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS) $(EEPROM_IMAGE) $(FLASH_IMAGE) $(ELFS) $(LSS) $(SIZEDUMMY) $(PROJECT).elf
	-@echo ' '
	-@cd ../A2D && $(MAKE) clean
	-@echo ' '
	-@cd ../USI_I2C && $(MAKE) clean
	-@echo ' '

secondary-outputs: $(LSS) $(FLASH_IMAGE) $(EEPROM_IMAGE) $(SIZEDUMMY)

install: fuses
	avrdude $(AVRDUDE_FLAGS) -p $(TARGET) -c $(PROGRAMMER) -P $(PORT) -v -U lfuse:w:0xff:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m

fuses:
	avrdude $(AVRDUDE_FLAGS) -p $(TARGET) -c $(PROGRAMMER) -P $(PORT) -v -U flash:w:$(PROJECT).hex

%.o: %.c
	@echo 'Building file: $<'
	avr-gcc $(INCLUDES) $(CFLAGS) -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
	
../A2D/libA2D.a:
	-cd ../A2D && $(MAKE) all

../USI_I2C/libUSI_I2C.a: ../A2D/libA2D.a
	-cd ../USI_I2C && $(MAKE) all
		
.PHONY: all clean dependents
.SECONDARY:
