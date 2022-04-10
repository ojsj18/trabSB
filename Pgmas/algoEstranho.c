#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
  void *i1, *i2;

  i1=sbrk(0);
  printf("%p\n",i1);
  i2=sbrk(0);
  printf("%p\n",i2);
  return (0);
}
