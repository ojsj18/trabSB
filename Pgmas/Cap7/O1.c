#include <stdio.h>

int P2 ();   // prototipos de funcoes declaradas em outros arquivos
int P3 ();
int P4 ();

int G1;                // global declarada neste arquivo 
extern int G2, G3, G4; // globais declaradas em outros arquivos

int main () {
  G1=15;
  P2(); G2=2;
  P3(); G3=3;
  P4(); G4=4;
}
