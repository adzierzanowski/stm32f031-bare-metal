TOOLCHAIN = arm-none-eabi
CC = $(TOOLCHAIN)-gcc
DB = $(TOOLCHAIN)-gdb
CP = $(TOOLCHAIN)-objcopy
SZ = $(TOOLCHAIN)-size
CFLAGS = --specs=nosys.specs -mcpu=cortex-m0 -mthumb -Wall -Iinc
LDFLAGS = -nostdlib -lgcc -T./linker.ld

ifeq ($(DEBUG), 1)
	CFLAGS += -Og -g
else
	CFLAGS += -O3
endif

SOURCES = vtable.s core.s main.c
SRC = src

all:
	$(CC) $(CFLAGS) $(LDFLAGS) $(addprefix $(SRC)/, $(SOURCES)) -o main.elf
	$(CP) main.elf -O binary main.bin
	$(SZ) main.elf

upload:
	st-flash write main.bin 0x8000000

debug:
	st-util&
	$(DB) main.elf -ex "tar extended-remote :4242"

clean:
	- rm *.o
	- rm *.bin
	- rm *.elf
