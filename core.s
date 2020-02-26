.syntax unified
.cpu cortex-m0
.fpu softvfp
.thumb

.global vtable
.global reset_handler

.type vtable, %object
vtable:
  .word _estack
  .word reset_handler

.size vtable, .-vtable

.type reset_handler, %function
reset_handler:
  ldr r0, =_estack
  mov sp, r0

  ldr r7, =0xdeadbeef
  movs r0, #0
  main:
    adds r0, r0, #1
    b main
.size reset_handler, .-reset_handler
