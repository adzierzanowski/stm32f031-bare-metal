CFLAGS = -mcpu=cortex-m0 -mthumb -Wall -Wpedantic -O0
LDFLAGS = --specs=nosys.specs -nostdlib -lgcc -T./linker.ld

all:
	arm-none-eabi-gcc -x assembler-with-cpp -c $(CFLAGS) core.s -o core.o
	arm-none-eabi-gcc $(CFLAGS) $(LDFLAGS) core.o -o main.elf
	arm-none-eabi-objcopy main.elf -O binary main.bin

upload:
	st-flash write main.bin 0x8000000

debug:
	st-util&
	arm-none-eabi-gdb main.elf -ex "tar extended-remote :4242"
