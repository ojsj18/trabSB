#include <stdio.h>
int globalB=2;
void b (char* s)
{
  printf("%s %d\n" , s, globalB);
}
