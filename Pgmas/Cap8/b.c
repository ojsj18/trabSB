#include <stdio.h>

long int gB_ext;
long int gB_int;

void b (char* s) {
  gB_ext=14;
  printf("gB_ext: (Valor=%02ld) (Endereco=%p)\n" , gB_ext, &gB_ext);

  gB_int=13;
  printf("gB_int: (Valor=%02ld) (Endereco=%p)\n" , gB_int, &gB_int);

  while (gB_ext < gB_int) {
    gB_ext = gB_ext +1;
  }
}
