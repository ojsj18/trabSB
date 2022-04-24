.section .data
   tam_heap:     .quad 0
   inicio:       .quad 0
   ini_heap:     .quad 0
   header:       .quad 16
   proximo:      .quad 0
   circular:     .quad 0
   bloco:        .quad 0 # ajustar isso
   a:            .quad 0
   b:            .quad 0
   c:            .quad 0
   d:            .quad 0
   e:            .quad 0
   bloco_teste_div:            .quad 32
   bloco_teste_aumenta:        .quad 80
   bloco_1:                    .quad 100
   bloco_2:                    .quad 200
   str1:     .string "começou a baixaria\n"
   str2:     .string "valor da heap %p\n"
   str3:     .string "status %d |tamanho %d |\n"
   str4:     .string "inicio %d |tamanho %d | ini_heap %d| proximo %d \n"
   str5:     .string "\n\n"
.section .text
.globl main

# a ideia é a mesma que o em c, porem aqui eu nao preciso calcular o inicio e o fim
# esta tudo nas variavel globais (lembrar de atualizalas)
# lembrar que andamos do começo do bloco livre
# ou seja as flags estao para tras

iniciaAlocador:
   pushq %rbp
   movq %rsp,%rbp

   movq $12, %rax              # chama a brk
   movq $0, %rdi               # chama a brk com 0(retorna topo em rax)
   syscall

  # os headers ficaram em -8 e -16 entao tem que andar 16 depois do inicio
   movq %rax,ini_heap    # ini-heap := endereço da heap
   addq header, %rax     # rax:= header |status tam|----------|
   movq %rax, inicio     # inicio := ini_heap+header
   movq %rax, proximo
   addq bloco,%rax       # rax:= ini_heap+header+novo_bloco
   movq %rax, tam_heap  

   movq $1,circular

   movq %rax,%rdi
   movq $12, %rax               #chama a brk
   syscall

   # coloca o header
   movq inicio,%rax
   movq $0,-16(%rax)  #STATUS
   movq bloco,%rdx
   movq %rdx,-8(%rax) #TAMANHO

   pop %rbp
   ret

# e se eu juntar o proximo?
# pergunto se quem eu vou juntar e o proximo, se for atualiza proximo
juntaBlocos:
    pushq %rbp
    movq %rsp,%rbp

    movq inicio,%r13       # i =inicio
    while_percorre_junta_blocos:
    cmpq %r13,tam_heap # if i<tam_heap
    jl fim_while_percorre_junta_blocos

    cmpq $0,-16(%r13)  # ve se ta livre
    jne fim_if_livre_junta_blocos
    movq -8(%r13), %r14
    addq %r13, %r14
    addq header, %r14

    cmpq %r14, tam_heap # arrumou problema do final da heap
    jl fim_while_percorre_junta_blocos

    cmpq $0, -16(%r14)  # r14 representa o proximo bloco
    jne fim_if_livre_junta_blocos
    cmpq proximo,%r14 # se for o proximo eu devo levar o proximo adiante
    jne juntar
    movq %r14,%rdi
    call busca_proximo
    juntar: 
    movq -8(%r14), %r15
    addq header, %r15
    addq %r15,-8(%r13)

    # booleano que verifica se eu juntei com o proximo ou nao
    # atualiza atual ao inves de ir pro proximo
    movq $0,%r12   
    fim_if_livre_junta_blocos:
    cmpq $0,%r12
    movq $1,%r12
    je while_percorre_junta_blocos
    addq -8(%r13),%r13    # calcula proximo bloco
    addq header,%r13
    jmp while_percorre_junta_blocos

    fim_while_percorre_junta_blocos:
    pop %rbp
    ret

# dado um endereço pega o proximo endereço livre
busca_proximo:
   pushq %rbp
   movq %rsp,%rbp

   movq %rdi,%r13 # pega o endereço que eu quero pegar o proximo
   addq -8(%r13),%r13    # calcula proximo bloco
   addq header,%r13

   cmpq %r13, tam_heap
   jne n_volta_inicio
   movq inicio,%r13
   movq $1,circular
   n_volta_inicio:
   movq %r13, proximo
   
   movq %r13,%rax
   pop %rbp
   ret

# passo o novo tamanho da pilha como sendo o valor inicial
finalizaAlocador:
   pushq %rbp
   movq %rsp,%rbp

   movq $12,%rax

   # preciso calcular o header no inicio
   movq ini_heap,%rdi
   syscall

   movq ini_heap,%rdx
   movq %rdx,tam_heap
   pop %rbp
   ret

liberaMem:
   pushq %rbp
   movq %rsp,%rbp
    
   # pergunta se o endereço que eu vou liberar e o q esta em proximo
   cmpq %rdi,proximo
   jne libera
   call busca_proximo
   # se nao so faz oq tem pra fazer
   libera:
   movq $0, -16(%rdi)

   call juntaBlocos
   
   pop %rbp
   ret

imprime_infs:
   pushq %rbp
   movq %rsp,%rbp

   movq $str4,%rdi 
   movq inicio,%rsi
   movq tam_heap,%rdx
   movq ini_heap,%rcx
   movq proximo, %r8
   call printf

   pop %rbp
   ret

imprimeMapa:
   pushq %rbp
   movq %rsp,%rbp

   movq inicio,%rbx      # i = inicio
   while_imprime:
   cmpq tam_heap,%rbx    # if i<tam_heap
   jge fim_while_imprime
   movq $str3,%rdi
   movq -16(%rbx),%rsi
   movq -8(%rbx),%rdx
   movq %rdx,%r12
   movq %rbx,%rcx
   call printf

   addq %r12,%rbx        # i=i+tam_bloco
   addq header,%rbx
   jmp  while_imprime

   fim_while_imprime:
   movq $str5,%rdi
   call printf
   pop %rbp
   ret

politica_de_escolha_nf:
   pushq %rbp
   movq %rsp,%rbp

   movq %rdi,%rax # pega tamanho que quer alocar
   movq proximo,%r13       # i = proximo
   while_percorre:
   cmpq %r13,tam_heap # if i<tam_heap
   jl fim_while_percorre
   cmpq $0,-16(%r13)  # ve se ta livre
   jne fim_if_livre
   cmpq -8(%r13),%rax   # se tamanho no bloco e disponivel
   jg fim_if_livre
   movq %r13, proximo  # foi o ultimo percorrido
   movq $0,circular  # se esta no meio nao se sabe se teve alteração nos anteriores  
   movq %r13,%rax
   pop %rbp
   ret

   fim_if_livre:
   addq -8(%r13),%r13    # calcula proximo bloco
   addq header,%r13
   jmp while_percorre

   # aqui eu abro mais espaço na heap
   fim_while_percorre:
   cmpq $1,circular  # se circulou == 1 entao aumenta a heap
   je ja_circulou
   
   movq $1,circular  # como vai voltar pro inicio entao vai ter circulado
   movq inicio,%r13
   jmp while_percorre

   ja_circulou:
   movq $1,circular
   movq %rax,%rdi # manda tamanho do bloco pra aumentar heap
   call aumenta_heap

   pop %rbp
   ret


aumenta_heap:
   pushq %rbp
   movq %rsp,%rbp

   movq %rdi,%r14 # salvo o tamanho do bloco

   movq tam_heap,%r13
   addq %rdi,%r13 # somo no final da heap o tamanho que eu quero
   addq header,%r13
   movq %r13,%rdi
   movq $12,%rdi
   syscall

   # coloca o header e devolve o novo bloco
   movq tam_heap,%rbx
   addq header,%rbx

   movq %r14,-16(%rbx)  # TAMANHO como estou no fim da heap e para frente
   movq $0,-8(%rbx)   # STATUS

   movq -16(%rbx),%rdx # ta funcionando
   movq %r13,tam_heap # atualizando o tamanho

   movq %rbx, proximo
   movq %rbx,%rax

   pop %rbp
   ret

alocaMem:
   pushq %rbp
   movq %rsp,%rbp

   movq %rdi,%r15

   call politica_de_escolha_nf

   movq $1,-16(%rax) # muda o status para ocupado
   movq -8(%rax),%r12 # salva o tamanho do bloco para calcular oq sobra

   movq %r15,-8(%rax) # substitui o tamanho antigo do bloco para o novo tamanho

   # calcular divisao dos blocos
   subq %r15,%r12     # calcula a diferença
   cmpq $0,%r12       # se for igual a zero nao precisa dividir o bloco
   je fim_calcula_bloco
   movq %rax,%r13  # r13 = endereço na heap
   addq %r15,%r13  # r13 + tamanho do bloco ocupado

   # aqui eu chego no final do bloco livre entao e pra frente que eu coloco
   addq header,%r13
   movq $0,-16(%r13) # coloca o 0 de livre no bloco novo

   # preciso retirar o tamanho do header
   subq header,%r12
   movq %r12,-8(%r13)

   fim_calcula_bloco:

   pop %rbp
   ret

main:
   pushq %rbp    
   movq %rsp, %rbp

   movq $str1, %rdi                   
   call printf
   
   call iniciaAlocador
   call imprime_infs
   call imprimeMapa

   movq $100,%rdi
   call alocaMem
   movq %rax,a
   movq $130,%rdi
   call alocaMem
   movq %rax,b
   movq $120,%rdi
   call alocaMem
   movq %rax,c
   movq $110,%rdi
   call alocaMem
   movq %rax,d
   call imprimeMapa
 
   movq b,%rdi
   call liberaMem
   call imprimeMapa

   movq d,%rdi
   call liberaMem
   call imprimeMapa

   movq $30,%rdi
   call alocaMem
   movq %rax,b
   call imprimeMapa
   movq $90,%rdi
   call alocaMem
   movq %rax,d
   call imprimeMapa
   movq $10,%rdi
   call alocaMem
   movq %rax,e
   call imprimeMapa


   movq c,%rdi
   call liberaMem
   call imprimeMapa

   movq a,%rdi
   call liberaMem
   call imprimeMapa

   movq b,%rdi
   call liberaMem
   call imprimeMapa

   movq d,%rdi
   call liberaMem
   call imprimeMapa

   movq e,%rdi
   call liberaMem
   call imprimeMapa

   movq $60, %rax
   syscall
   