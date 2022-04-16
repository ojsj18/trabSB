#include <stdio.h>
#include "meuAlocador.h"

int main (long int argc, char** argv) {
  void *a,*b,*c,*d,*e;

  iniciaAlocador(); //passou
  imprimeMapa();
  // 0) estado inicial

  a=(void *) alocaMem(100);
  imprimeMapa();
  b=(void *) alocaMem(130); //passou
  imprimeMapa();
  c=(void *) alocaMem(120);
  imprimeMapa();
  d=(void *) alocaMem(110);
  imprimeMapa();
  // 1) Espero ver quatro segmentos ocupados

  liberaMem(b);
  imprimeMapa(); //passou
  liberaMem(d);
  imprimeMapa(); 
  // 2) Espero ver quatro segmentos alternando
  //    ocupados e livres

  b=(void *) alocaMem(30);
  imprimeMapa();
  d=(void *) alocaMem(90); //ta funcionando
  imprimeMapa();
  e=(void *) alocaMem(10);
  imprimeMapa();
  // // 3) Deduzam
	
  liberaMem(c);
  imprimeMapa(); 
  liberaMem(a);
  imprimeMapa();
  liberaMem(b);
  imprimeMapa();
  liberaMem(d);
  imprimeMapa();
  liberaMem(e);
  imprimeMapa();
   // 4) volta ao estado inicial

  finalizaAlocador();
}
