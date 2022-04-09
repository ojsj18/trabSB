//arquivo para ter noção de quantas linhas serao traduzidas para assembly
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int junta_blocos(int* heap){
    int tam_heap = brk(heap);
    int i = 0;
    int tam_proximo;

    while(i<tam_heap){
        if(heap[i]==1){
            tam_proximo = heap[i+1]+2+i;
            if(heap[tam_proximo]==1)
                heap[i+1]=heap[i+1]+2+heap[tam_proximo+1];
        }

        i=i+2+heap[i+1];
    }
}

int politica_de_escolha(int* heap,int tam){
    int i = 0;
    int tam_heap = brk(heap);

    while(i<tam_heap){
        if(heap[i]==1){
            if(heap[i+1]>=tam)
                return i;
        }
        i=i+2+heap[i+1];
    }
}

void iniciaAlocador(int tam, int* heap){
    int i=0;

    heap[0]=1;
    heap[1]=tam;
    
    while(i != tam+2){
        i++;
    }

    heap[i]=3;
}

void alocaMem(int tam, int heap[]){
    
    int tam_heap = brk(heap);
    int inicio = politica_de_escolha(heap,tam);
    int tam_livre = heap[inicio+1];

    if(tam+2<=tam_livre)
        heap[tam+inicio+2] = 1;
        heap[tam+inicio+3] = tam_livre-tam-2;

    heap[inicio] = 2;
    heap[inicio+1] = tam;

}

int liberaMem(int bloco, int heap[]){
    heap[bloco-2] = 1;
    junta_blocos(heap);
}
