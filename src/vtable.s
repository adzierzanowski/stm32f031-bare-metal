.syntax unified
.cpu cortex-m0
.fpu softvfp
.thumb

.global vtable
.global default_interrupt_handler

.type vtable, %object
.section .vector_table, "a", %progbits
vtable:
  .word _estack
  .word  reset_handler
  .word  NMI_handler
  .word  hard_fault_handler
  .word  0
  .word  0
  .word  0
  .word  0
  .word  0
  .word  0
  .word  0
  .word  SVC_handler
  .word  0
  .word  0
  .word  pending_SV_handler
  .word  sys_tick_handler
  .word  WWDG_IRQ_handler                  /* Window WatchDog              */
  .word  PVD_IRQ_handler                   /* PVD through EXTI Line detect */
  .word  RTC_IRQ_handler                   /* RTC through the EXTI line    */
  .word  FLASH_IRQ_handler                 /* FLASH                        */
  .word  RCC_IRQ_handler                   /* RCC                          */
  .word  EXTI0_1_IRQ_handler               /* EXTI Line 0 and 1            */
  .word  EXTI2_3_IRQ_handler               /* EXTI Line 2 and 3            */
  .word  EXTI4_15_IRQ_handler              /* EXTI Line 4 to 15            */
  .word  0                                 /* Reserved                     */
  .word  DMA1_channel1_IRQ_handler         /* DMA1 Channel 1               */
  .word  DMA1_channel2_3_IRQ_handler       /* DMA1 Channel 2 and Channel 3 */
  .word  DMA1_channel4_5_IRQ_handler       /* DMA1 Channel 4 and Channel 5 */
  .word  ADC1_IRQ_handler                  /* ADC1                         */
  .word  TIM1_BRK_UP_TRG_COM_IRQ_handler   /* TIM1 Break, Update, Trigger and Commutation */
  .word  TIM1_CC_IRQ_handler               /* TIM1 Capture Compare         */
  .word  TIM2_IRQ_handler                  /* TIM2                         */
  .word  TIM3_IRQ_handler                  /* TIM3                         */
  .word  0                                 /* Reserved                     */
  .word  0                                 /* Reserved                     */
  .word  TIM14_IRQ_handler                 /* TIM14                        */
  .word  0                                 /* Reserved                     */
  .word  TIM16_IRQ_handler                 /* TIM16                        */
  .word  TIM17_IRQ_handler                 /* TIM17                        */
  .word  I2C1_IRQ_handler                  /* I2C1                         */
  .word  0                                 /* Reserved                     */
  .word  SPI1_IRQ_handler                  /* SPI1                         */
  .word  0                                 /* Reserved                     */
  .word  USART1_IRQ_handler                /* USART1                       */
  .word  0                                 /* Reserved                     */
  .word  0                                 /* Reserved                     */
  .word  0                                 /* Reserved                     */
  .word  0                                 /* Reserved                     */

  .equ boot_RAM_base, 0xf108f85f
  .word boot_RAM_base

  .weak  NMI_handler
  .thumb_set NMI_handler, default_interrupt_handler
  .weak  hard_fault_handler
  .thumb_set hard_fault_handler, default_interrupt_handler
  .weak  SVC_handler
  .thumb_set SVC_handler, default_interrupt_handler
  .weak  pending_SV_handler
  .thumb_set pending_SV_handler, default_interrupt_handler
  .weak  sys_tick_handler
  .thumb_set sys_tick_handler, default_interrupt_handler
  .weak  WWDG_IRQ_handler
  .thumb_set WWDG_IRQ_handler, default_interrupt_handler
  .weak  PVD_IRQ_handler
  .thumb_set PVD_IRQ_handler, default_interrupt_handler
  .weak  RTC_IRQ_handler
  .thumb_set RTC_IRQ_handler, default_interrupt_handler
  .weak  FLASH_IRQ_handler
  .thumb_set FLASH_IRQ_handler, default_interrupt_handler
  .weak  RCC_IRQ_handler
  .thumb_set RCC_IRQ_handler, default_interrupt_handler
  .weak  EXTI0_1_IRQ_handler
  .thumb_set EXTI0_1_IRQ_handler, default_interrupt_handler
  .weak  EXTI2_3_IRQ_handler
  .thumb_set EXTI2_3_IRQ_handler, default_interrupt_handler
  .weak  EXTI4_15_IRQ_handler
  .thumb_set EXTI4_15_IRQ_handler, default_interrupt_handler
  .weak  DMA1_channel1_IRQ_handler
  .thumb_set DMA1_channel1_IRQ_handler, default_interrupt_handler
  .weak  DMA1_channel2_3_IRQ_handler
  .thumb_set DMA1_channel2_3_IRQ_handler, default_interrupt_handler
  .weak  DMA1_channel4_5_IRQ_handler
  .thumb_set DMA1_channel4_5_IRQ_handler, default_interrupt_handler
  .weak  ADC1_IRQ_handler
  .thumb_set ADC1_IRQ_handler, default_interrupt_handler
  .weak  TIM1_BRK_UP_TRG_COM_IRQ_handler
  .thumb_set TIM1_BRK_UP_TRG_COM_IRQ_handler, default_interrupt_handler
  .weak  TIM1_CC_IRQ_handler
  .thumb_set TIM1_CC_IRQ_handler, default_interrupt_handler
  .weak  TIM2_IRQ_handler
  .thumb_set TIM2_IRQ_handler, default_interrupt_handler
  .weak  TIM3_IRQ_handler
  .thumb_set TIM3_IRQ_handler, default_interrupt_handler
  .weak  TIM14_IRQ_handler
  .thumb_set TIM14_IRQ_handler, default_interrupt_handler
  .weak  TIM16_IRQ_handler
  .thumb_set TIM16_IRQ_handler, default_interrupt_handler
  .weak  TIM17_IRQ_handler
  .thumb_set TIM17_IRQ_handler, default_interrupt_handler
  .weak  I2C1_IRQ_handler
  .thumb_set I2C1_IRQ_handler, default_interrupt_handler
  .weak  SPI1_IRQ_handler
  .thumb_set SPI1_IRQ_handler, default_interrupt_handler
  .weak  USART1_IRQ_handler
  .thumb_set USART1_IRQ_handler, default_interrupt_handler

.size vtable, .-vtable

.section .text.default_interrupt_handler, "ax", %progbits
default_interrupt_handler:
  default_interrupt_handler_loop:
    b default_interrupt_handler_loop
.size default_interrupt_handler, .-default_interrupt_handler
