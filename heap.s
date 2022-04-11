.section .data
   tam_heap: .quad 0
   inicio:   .quad 0
   header:   .quad 16
   str1:     .string "começou a baixaria\n"
   str2:     .string "valor da heap %p\n"
   str3:     .string "status %d |tamanho %d\n"
.section .text
.globl main

#a ideia é a mesma que o em c, porem aqui eu nao preciso calcular o inicio e o fim
#esta tudo nas variavel globais (lembrar de atualizalas)
iniciaAlocador:
   pushq %rbp
   movq %rsp,%rbp
   movq $12, %rax               #chama a brk
   movq $0, %rdi               #chama a brk com 0(retorna topo em rax)
   syscall

#####com problema
  #abre espaço pro primeiro header
   addq $100,%rax       
   movq %rax, tam_heap
   movq %rax, inicio
   movq %rax,%rdi
   movq $12, %rax               #chama a brk
   syscall

   #coloca o header
   movq inicio,%rax
   movq $0,-8(%rax)  #STATUS
   movq $10,-16(%rax) #TAMANHO

   ##############
   pop %rbp
   ret

#passo o novo tamanho da pilha como sendo o valor inicial
finalizaAlocador:
   pushq %rbp
   movq %rsp,%rbp

   movq $12,%rax

   #preciso calcular o header no inicio
   movq inicio,%rdi
   syscall

   pop %rbp
   ret
   
politica_de_escolha:
   pushq %rbp
   movq %rsp,%rbp

   movq 16(%rbp),%rax #pega tamanho qu quer alocar
   movq inicio,%rdx       #i =inicio
   while_percorre:
   cmpq %rdx,tam_heap #if i<tam_heap
   jl fim_while_percorre
   cmpq $1,-8(%rdx)  # ve se ta livre
   jne fim_if_livre
   cmpq -16(%rdx),%rax   #se tamanho no bloco e disponivel
   jle fim_if_livre
   movq %rdx,%rdi
   pop %rbp
   ret

   fim_if_livre:
   addq -16(%rbx),%rdx    #calcula proximo bloco
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
   movq $0,-16(%rdx)  #TAMANHO
   movq $0,-8(%rdx)   #STATUS
   movq %rdx,%rdi
   pop %rbp
   ret

alocaMem:
   pushq %rbp
   movq %rsp,%rbp

   pushq %rdi #empilha primeiro parametro
   call politica_de_escolha
   addq $16, %rsp

main:
   pushq %rbp       #bateu a duvida do pq preciso salvar rbp nesse caso                               
   movq %rsp, %rbp 

   movq $str1, %rdi                   
   call printf

   movq $12, %rax              #chama a brk
   movq $0, %rdi              #chama a brk com 10 de
   syscall       
   movq %rax, %rsi           
   movq $str2, %rdi                   
   call printf
   
   call iniciaAlocador

   movq $12, %rax             #chama a brk
   movq $0, %rdi              #tamanho heap
   syscall       
   movq %rax, %rsi           
   movq $str2, %rdi                   
   call printf

   movq inicio,%rax
   movq -8(%rax),%rsi  #to indo pra tras ou pra frente?
   movq -16(%rax),%rdx
   movq $str3, %rdi
   call printf


#teste da funcao  politica_de_escolha
   push $16
   call politica_de_escolha
   addq $8,%rsp #libera parametros

   movq %rdi, %rsi           
   movq $str2, %rdi                   
   call printf

#teste da funcao  politica_de_escolha de novo
   push $32
   call politica_de_escolha
   addq $8,%rsp #libera parametros

   movq %rdi, %rsi           
   movq $str2, %rdi                   
   call printf

   movq $60, %rax
   syscall
   