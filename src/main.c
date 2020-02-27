#include "stm32f031x6.h"


volatile uint32_t ticks = 0;

void sys_tick_handler(void)
{
  ticks++;
}

void delay_ms(uint32_t ms)
{
  volatile uint32_t start = ticks;
  while (ticks - start < ms)
    __NOP();
  return;
}

int main(void)
{
  RCC->AHBENR |= RCC_AHBENR_GPIOBEN;
  GPIOB->MODER &= ~(0b11 << 3 * 2);
  GPIOB->MODER |= (0b01 << 3 * 2);
  GPIOB->OTYPER &= ~(1 << 3);

  // no need to enable irq as apparently it's enabled by default
  SysTick_Config(8000000 / 1000);

  for(;;)
  {
    GPIOB->BSRR = 1 << 3;
    delay_ms(100);
    GPIOB->BRR = 1 << 3;
    delay_ms(100);
  }
}
