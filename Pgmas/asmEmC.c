#include<stdio.h>
int main (long int argc, char **argv)
{
  long int x;
  __asm__("movq $100, -8(%rbp)");
  printf("x=%ld\n", x);

  return (0);
}
