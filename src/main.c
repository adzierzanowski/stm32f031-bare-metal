#include <stdbool.h>

#include "stm32f031x6.h"

#define CPU_F 8000000

volatile uint32_t ticks = 0;
volatile bool led_on = false;
volatile uint32_t last_led_change = 0;

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

void gpio_setup(void);
void btn_setup(void);
void EXTI4_15_IRQ_handler(void);

int main(void)
{
  gpio_setup();
  btn_setup();

  // Set up an interrupt every 1 ms;
  // no need to enable irq as apparently it's enabled by default.
  SysTick_Config(CPU_F / 1000);

  for(;;)
  {
    if (led_on)
      GPIOB->BSRR = 1 << 3;
    else
      GPIOB->BRR = 1 << 3;
    delay_ms(100);
  }
}

void gpio_setup(void)
{
  // Connect the port to clock source
  RCC->AHBENR |= RCC_AHBENR_GPIOBEN;

  // Set PB3 as output
  GPIOB->MODER &= ~(0b11 << 3 * 2);
  GPIOB->MODER |= (0b01 << 3 * 2);

  // Set PB3 as push-pull
  GPIOB->OTYPER &= ~(1 << 3);
}

void btn_setup(void)
{
  RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;
  SYSCFG->EXTICR[1] |= SYSCFG_EXTICR2_EXTI4_PB; // Set exti port for pin 4
  EXTI->IMR |= (1 << 4); // enable EXTI interrupt on pin PB4
  EXTI->RTSR &= ~(1 << 4); // disable rising edge detection
  EXTI->FTSR |= (1 << 4); // enable falling edge detection
  GPIOB->PUPDR |= (0b01 << 4 * 2); // terrain ahead, pull up
  NVIC_SetPriority(EXTI4_15_IRQn, 0x03);
  NVIC_EnableIRQ(EXTI4_15_IRQn);
}

void EXTI4_15_IRQ_handler(void)
{
  if (EXTI->PR & (1 << 4))
  {
    if (ticks - last_led_change > 250)
    {
      led_on = !led_on;
      last_led_change = ticks;
    }

    EXTI->PR |= (1 << 4);
  }
}
