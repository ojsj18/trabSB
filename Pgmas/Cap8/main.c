#include <stdio.h>

extern long int gA_ext;
extern long int gB_ext;

long int gMain;

void a (char* s);
void b (char* s);

long int main ()
{
  gA_ext=15;
  gB_ext=14;

  printf ("Procedimento main: (Endereco=%p)\n", main);
  printf ("Procedimento a: (Endereco=%p)\n", a);
  printf ("Procedimento b: (Endereco=%p)\n", b);
  printf ("Procedimento printf: (Endereco=%p)\n", printf);

  a("dentro de a\n");
  b("dentro de b\n");
}
