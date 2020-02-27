ENTRY(reset_handler);

_estack = 0x20001000;

_Min_Leftover_RAM = 0x400;

MEMORY
{
  FLASH(rx): ORIGIN = 0x08000000, LENGTH = 32K
  RAM(rxw): ORIGIN = 0x20000000, LENGTH = 4K
}

SECTIONS
{
  .vector_table :
  {
    . = ALIGN(4);
    KEEP(*(.vector_table))
    . = ALIGN(4);
  } > FLASH

  .text : /* main code */
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    . = ALIGN(4);
  } > FLASH

  .rodata : /* read-only data */
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } > FLASH

  _sidata = .;
  .data : AT(_sidata)
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data*)
    _edata = .;
    . = ALIGN(4);
  } > RAM

  .bss : /* zero-initialized data */
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    *(.bss*)
    *(COMMON)
    _ebss = .;
    . = ALIGN(4);
  } > RAM

  .dynamic_allocations :
  {
    . = ALIGN(4);
    _ssystem_ram = .;
    . = . + _Min_Leftover_RAM;
    . = ALIGN(4);
    _esystem_ram = .;
  } > RAM
}
