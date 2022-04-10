#include <stdio.h>               
int main (long  int argc, char **argv, char **arge) 
{         
  long  int i;                      
 
  // -------- Imprime argc  --------
  printf("[%p]: argc=%ld\n", &argc, argc);        
 
  // -------- Imprime argv -------- 
  // for (i=0; argv[i] != NULL; i++) : Tambem funciona   
  for (i=0; i<argc; i++)        
    printf("[%p]: argv[%ld]=%s %p\n",  &argv[i], i, argv[i],  argv[i]); 
  printf("[%p]: argv[%ld]=%s %p\n",  &argv[i], i, argv[i],  argv[i]); 
 
  // -------- Imprime arge -------- 
  for (i=0; arge[i] != NULL; i++)
    printf("[%p]: arge[%ld]=%s %p\n", &arge[i], i, arge[i],  argv[i]);
  printf("[%p]: arge[%ld]=%s %p\n", &arge[i], i, arge[i],  argv[i]);

  return (0);
}
