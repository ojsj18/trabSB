#include <stdio.h>
int globalC=3;
void c (char* s)
{
  printf("%s %d\n" , s, globalC);
}
