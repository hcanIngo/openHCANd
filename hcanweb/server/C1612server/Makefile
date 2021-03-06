# Makfile fuer C1612-canWebServer
# 
#
include ../../../ARCH.inc

OBJ_LOCAL := $(patsubst %.c,%.o,$(wildcard *.c))

.PHONY:	release

#Der atmega644 hat die doppelte EEPROM- und SRAM-Groesse gegenueber dem atmega32.
export MCU_Server = atmega644

TARGET = main
adr = 166

export CC = avr-gcc
export OBJCOPY = avr-objcopy
OBJ     = ../../../canix/canix.o ../../../canix/mcp2515.o \
		  ../../../canix/tools.o ../../../canix/hcan_hms.o \
		  ../../../canix/hcan_rts.o ../../../canix/syslog.o \
		  ../../../canix/eds.o \
		  ../../../canix/mem_check.o \
		  ../shared_client_interface.o \
		  ../shared_hms_interface.o \
		  ./web/enc28j60.o \
		  ./web/ip_arp_udp_tcp.o \
		  ./web/dhcp_client.o \
		  ./web/websrv_help_functions.o \
		  $(OBJ_LOCAL)


export F_CPU  = 3686400
export F_CAN   = 8000000
export CAN_SPEED = 125000

export DEFINES = -DMCU_$(MCU_Server) \
        -DF_CPU=$(F_CPU) -DF_CAN=$(F_CAN) -DCAN_SPEED=$(CAN_SPEED) \
        -DCANIX_SYSLOG -DCANIX_HMS -DCANIX_RTS \
        -DCANIX_EDS $(FEATURES)

export GCCFLAGS = -mmcu=$(MCU_Server) -Wall -Wstrict-prototypes -Os \
        -mcall-prologues \
        -std=gnu99

INC = -I./web -I. -I.. -I../../../canix -I../../.. -I../../../include
CFLAGS= $(GCCFLAGS) $(INC) $(DEFINES)

all: $(TARGET).hex
	test -d ./C1612_$(MCU_Server) || mkdir C1612_$(MCU_Server)
	sudo mv $(TARGET).hex C1612_$(MCU_Server)
	ls ./C1612_$(MCU_Server)/*.*

$(TARGET).hex : $(TARGET).out
	$(OBJCOPY) -R .eeprom -O ihex $(TARGET).out $(TARGET).hex 
	avr-size $(TARGET).hex

$(TARGET).out : $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET).out -Wl,-Map,$(TARGET).map $(OBJ) $(LDFLAGS)

clean:
	rm -f *.o *.lst *.map *.out ../../../canix/*.o
	rm -f ../*.o ../*.lst
	rm -f ./web/*.o ./web/*.lst
	sudo rm -f ./C1612_$(MCU_Server)/*.hex

ctags:
	ctags *.c *.h ../../../canix/*.c ../../../canix/*.h ../../../include/*.h

load:
	make all
	@echo -------------------------
	@echo Bsp.:  make load adr=166
	@echo -------------------------
	telican -a $(IP_HI) -c $(adr) --arch $(MCU_Server) -e "flash C1612_$(MCU_Server)/$(TARGET).hex"
	@#telican -a $(IP_HI) -c $(adr) --arch $(MCU_Server) -e "flash C1612_$(MCU_Server)/$(TARGET).hex"
