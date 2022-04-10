#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  char *p, *q, *t;
  int i;
  p = malloc(1024);
  q = malloc(1024);
  for (i=0; i<100; i++){
    free (p);
    p = malloc(1);
    p = malloc(1024);
    t=p; p=q; q=t;
  }
  free(q);
  free(p);
  return 0;
}
