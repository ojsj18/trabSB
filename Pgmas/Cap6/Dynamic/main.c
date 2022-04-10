#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

int main ( int argc, char** argv ){
  char opcao;
  void* handle;
  void* (*funcao)(char*);
  char* error;
  char* nomeBib="/usr/lib/libMyDynamicLib.so";
  char* path;
  char s[100];

  do{
    printf("Digite (a) para uma funcao e (b) para a outra \n");
    scanf ("%c", &opcao );
  } while (opcao!='a' && opcao!='b');

  path = getenv ("HOME");
  sprintf(s, "%s%s", path, nomeBib);

  handle = dlopen(s, RTLD_LAZY);
  error = dlerror();
  if ( error ){
    printf("Erro ao abrir %s", s );
    exit (1);
  }

  if ( opcao == 'a' )
    funcao = dlsym(handle, "a");
  else
    funcao = dlsym(handle, "b");

  funcao ("texto\n");

  dlclose (handle);
}
