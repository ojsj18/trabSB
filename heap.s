.section .data
   tam_heap:     .quad 0
   inicio:       .quad 0
   ini_heap:     .quad 0
   header:       .quad 16
   bloco:        .quad 64
   str1:     .string "começou a baixaria\n"
   str2:     .string "valor da heap %p\n"
   str3:     .string "status %d |tamanho %d\n"
   str4:     .string "inicio %d |tamanho %d | ini_heap %d \n"
.section .text
.globl main

#a ideia é a mesma que o em c, porem aqui eu nao preciso calcular o inicio e o fim
#esta tudo nas variavel globais (lembrar de atualizalas)
#lembrar que andamos do começo do bloco livre
#ou seja as flags estao para tras

iniciaAlocador:
   pushq %rbp
   movq %rsp,%rbp

   movq $12, %rax              #chama a brk
   movq $0, %rdi               #chama a brk com 0(retorna topo em rax)
   syscall

  #os headers ficaram em -8 e -16 entao tem que andar 16 depois do inicio
   movq %rax,ini_heap    #ini-heap := endereço da heap
   addq header, %rax     # rax:= header |status tam|----------|
   movq %rax, inicio     # inicio := ini_heap+header 
   addq bloco,%rax       # rax:= ini_heap+header+novo_bloco
   movq %rax, tam_heap  

   movq %rax,%rdi
   movq $12, %rax               #chama a brk
   syscall

   #coloca o header
   movq inicio,%rax
   movq $0,-16(%rax)  #STATUS
   movq bloco,%rdx
   movq %rdx,-8(%rax) #TAMANHO

   pop %rbp
   ret

#passo o novo tamanho da pilha como sendo o valor inicial
finalizaAlocador:
   pushq %rbp
   movq %rsp,%rbp

   movq $12,%rax

   #preciso calcular o header no inicio
   movq ini_heap,%rdi
   syscall

   pop %rbp
   ret

imprime_infs:
   pushq %rbp
   movq %rsp,%rbp

   movq $str4,%rdi 
   movq inicio,%rsi
   movq tam_heap,%rdx
   movq ini_heap,%rcx
   call printf

   pop %rbp
   ret

imprime_mapa:
   pushq %rbp
   movq %rsp,%rbp

   movq inicio,%rbx      #i = inicio
   while_imprime:
   cmpq tam_heap,%rbx    #if i<tam_heap
   jge fim_while_imprime
   movq $str3,%rdi
   movq -16(%rbx),%rsi
   movq -8(%rbx),%rdx
   movq %rdx,%r12
   call printf

   addq %r12,%rbx        #i=i+tam_bloco
   addq header,%rbx
   jmp  while_imprime

   fim_while_imprime:
   pop %rbp
   ret

politica_de_escolha:
   pushq %rbp
   movq %rsp,%rbp

   movq %rdi,%rax #pega tamanho que quer alocar
   movq inicio,%rdx       #i =inicio
   while_percorre:
   cmpq %rdx,tam_heap #if i<tam_heap
   jl fim_while_percorre
   cmpq $0,-16(%rdx)  # ve se ta livre
   jne fim_if_livre
   cmpq -8(%rdx),%rax   #se tamanho no bloco e disponivel
   jg fim_if_livre
   movq %rdx,%rax
   pop %rbp
   ret

   fim_if_livre:
   addq -8(%rax),%rdx    #calcula proximo bloco
   addq header,%rdx
   jmp while_percorre

   #aqui eu abro mais espaço na heap
   fim_while_percorre:
   movq tam_heap,%rdx
   addq %rax,%rdx
   addq header,%rdx
   movq %rdx,%rdi
   movq $12,%rax
   syscall

   #coloca o header e devolve o novo bloco
   movq $0,16(%rdx)  #TAMANHO
   movq $0,8(%rdx)   #STATUS
   movq %rdx,%rax
   pop %rbp
   ret

alocaMem:
   pushq %rbp
   movq %rsp,%rbp

   pushq %rdi
   call politica_de_escolha

   movq $1,-16(%rax)
   movq %rdi,-8(%rax)

   #calcular divisao dos blocos
   call imprime_mapa
   
   pop %rbp
   ret

main:
   pushq %rbp    
   movq %rsp, %rbp 

   movq $str1, %rdi                   
   call printf
   
   call iniciaAlocador
   call imprime_infs
   call imprime_mapa

   movq bloco,%rdi
   pushq %rdi
   call alocaMem

   movq $60, %rax
   syscall
   