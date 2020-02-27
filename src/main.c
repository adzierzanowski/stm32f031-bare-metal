#include "stm32f031x6.h"


void sys_tick_handler(void)
{
  return;
}

int main(void)
{
  RCC->AHBENR |= RCC_AHBENR_GPIOBEN;
  GPIOB->MODER &= ~(0b11 << 3 * 2);
  GPIOB->MODER |= (0b01 << 3 * 2);
  GPIOB->OTYPER &= ~(1 << 3);

  for(;;)
  {
    GPIOB->BSRR = 1 << 3;
    for (int i = 0; i < 80000; i++);
    GPIOB->BRR = 1 << 3;
    for (int i = 0; i < 80000; i++);
  }
}
