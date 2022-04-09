#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//fazer lista encadeada onde o no atual conhece o anterior e o proximo?

// iniciaAlocador, finalizaAlocador, alocaMem, liberaMem e o imprimeMapa
//codigo base para trabalho sb comentado

//nao tem tratamento de erro pois nao sei se vamos precisar implementar isso

//precisa implementar quando chegarmos no topo da heap abrir mais espaço
//acho que isso sera mais facil usando a brk

//representa syscall 12 que retorna tamanho da heap
//em assembly isso nao vai precisar ser feito pois usamos a syscall
int brk(int* heap){
    int i=0;

    while(heap[i]!= 3){
        i=i+heap[i+1]+2;
    }
    return i;

}

//usado apenas para zerar e ficar mais facil a visualização
void zera(int* heap, int tam){
    int i=0;

    while(i<=tam){
        heap[i]=0;
        i++;
    }

}

//algoritimo que percorre e junta os blocos seguidos que sao livres
//onde colocalos?
//so olho para frente? isso nao gera um problema
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

//atualmente pega o menor bloco livre encontrado
//fazer separado pq fica mais facil para alterarmos
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

//seria o equivalente a chamar o brk pro tamanho indicado
//seguido de colocar os indices
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

//pq tem que ser int?
int liberaMem(int bloco, int heap[]){
    heap[bloco-2] = 1;
    junta_blocos(heap);
}

void imprimeMapa(int heap[]){
    int i=0;
    int tam_heap = brk(heap);

    while(i<tam_heap){
        if(heap[i]==1)
            printf("L, %d ",heap[i+1]);
        else
            printf("O, %d ",heap[i+1]);
        i=i+2+heap[i+1];
    }
    printf("\n");
}
void imprimeHeap(int* heap){
    int i=0;
    int tam_heap = 12;

    printf("%d |",tam_heap);

    while(i<=tam_heap){
        printf("%d ",heap[i]);
        i++;
    }
    printf("\n");
}

void main(){
    printf("trabalho SB \n");
    int simulador_heap[1000];
    zera(simulador_heap,1000);
    iniciaAlocador(10,simulador_heap);
    imprimeHeap(simulador_heap);
    imprimeMapa(simulador_heap);


    alocaMem(2,simulador_heap);
    imprimeHeap(simulador_heap);
    imprimeMapa(simulador_heap);

    alocaMem(2,simulador_heap);
    imprimeHeap(simulador_heap);
    imprimeMapa(simulador_heap);

    alocaMem(2,simulador_heap);
    imprimeHeap(simulador_heap);
    imprimeMapa(simulador_heap);

    liberaMem(10,simulador_heap);
    liberaMem(6,simulador_heap);
    liberaMem(2,simulador_heap);
    
    imprimeHeap(simulador_heap);
    imprimeMapa(simulador_heap);

}
