#include <stdio.h>
int globalA=1;
void a (char* s)
{
  printf("%s %d\n" , s, globalA);
}
