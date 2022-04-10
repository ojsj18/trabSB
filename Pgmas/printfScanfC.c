#include <stdio.h>
int main (long  int argc, char **argv)
{
  long  int x, y;
  printf("Digite dois numeros:\n");
  scanf ("%ld %ld"  , &x, &y);
  printf("Os numeros digitados foram %ld %ld \n"  , x, y);

  return (0);
}
