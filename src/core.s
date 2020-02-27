.syntax unified
.cpu cortex-m0
.fpu softvfp
.thumb

.global reset_handler

.type reset_handler, %function
reset_handler:
  ldr r0, =_estack
  mov sp, r0

  // Copy data into RAM
  movs r0, #0
  ldr r1, =_sdata
  ldr r2, =_edata
  ldr r3, =_sidata

  copy_sidata:
    ldr r4, [r3, r0]
    str r4, [r1, r0]
    adds r0, r0, #4

  copy_sidata_loop:
    adds r4, r0, r1
    cmp r4, r2
    bcc copy_sidata

  // Zero bss section
  movs r0, #0
  ldr r1, =_sbss
  ldr r2, =_ebss
  b reset_bss_loop

  reset_bss:
    str r0, [r1]
    adds r1, r1, #4

  reset_bss_loop:
    cmp r1, r2
    bcc reset_bss
  
  b main

loop_forever:
  b loop_forever

.size reset_handler, .-reset_handler
