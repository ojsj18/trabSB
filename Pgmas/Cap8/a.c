#include <stdio.h>

long int gA_ext;
long int gA_int;

void funcao_interna_em_a (long int x) {
    gA_int = gA_int + x;
 }

void a (char* s) {
  gA_ext=16;
  printf("gA_ext: (Valor=%02ld) (Endereco=%p)\n", gA_ext, &gA_ext);

  gA_int=15;
  printf("gA_int: (Valor=%02ld) (Endereco=%p)\n", gA_int, &gA_int);

  funcao_interna_em_a(15);
  printf("funcao_interna_em_a:(Endereco=%p)\n", &funcao_interna_em_a);
}
