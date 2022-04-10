#include<stdio.h> 

int f() 
{ 
  static int contador = 0; 
  contador++; 
  return contador; 
} 
   
int main() 
{ 
  printf("%d ", f()); 
  printf("%d \n", f()); 
  return 0; 
}
