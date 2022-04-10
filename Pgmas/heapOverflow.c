#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TAMANHO 1024

int main(int argc, char **argv) {
   char *p, *q;
   int i;

   p = malloc(TAMANHO);
   q = malloc(TAMANHO);
   if (argc >= 2)
     strcpy(p, argv[1]);

   free(q);
   free(p);

   return 0;
}
