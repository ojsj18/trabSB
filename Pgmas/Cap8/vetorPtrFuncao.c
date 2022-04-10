#include <stdio.h>

long int soma(long int a, long int b){
  return a + b;
}

long int subt(long int a, long int b){
  return a - b;
}

long int mult(long int a, long int b){
  return a * b;
}

long int divi(long int a, long int b){
  if(b) 
      return a / b;
  else 
      return 0;
}

long int (*vetPtrFunc[4]) (long int x, long int y);

long int main(long int argc, char **argv){
  long int i, j;

  vetPtrFunc[0] = soma; 
  vetPtrFunc[1] = subt; 
  vetPtrFunc[2] = mult; 
  vetPtrFunc[3] = divi;

  // operacao: i=(1+2)-(4/3)*5

  i = vetPtrFunc[0](1,2);
  j = vetPtrFunc[3](4,3);
  j = vetPtrFunc[2](j,5);
  i = vetPtrFunc[1](i,j);
  printf ("%ld\n", i);
}
