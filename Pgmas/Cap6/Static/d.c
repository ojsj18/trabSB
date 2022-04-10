#include <stdio.h>
int globalD=4;
void d (char* s)
{
  printf("%s %d\n" , s, globalD);
}
