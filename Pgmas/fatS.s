
.section .data
.section .text
.globl _start
fat:
   pushq %rbp                   # empilha %rbp                    
   movq  %rsp, %rbp             # faz %rbp apontar para novo R.A. 
   subq $8, %rsp                # long int r (em -8(%rbp))        
   movq 24(%rbp), %rax          # %rax := n
   movq $1, %rbx                # %rbx := 1      
   cmpq %rbx, %rax
   jg else                      #  desvia se n>1
   movq 16(%rbp), %rax          #  %rax := res
   movq $1, (%rax)              # *res := 1
   jmp fim_if
else:
   movq 24(%rbp), %rax          #  %rax := n
   subq $1, %rax                #  %rax := n-1  
   pushq %rax                   #  empilha %rax
   pushq 16(%rbp)               #  empilha res
   call fat
   addq $16, %rsp               #  desempilha parametros
   movq 16(%rbp), %rax          #  %rax := res
   movq (%rax), %rax            #  %rax := *res
   movq 24(%rbp), %rbx          #  %rbx := n
   imul %rbx, %rax              #  %rax := %rax * %rbx 
   movq %rax, -8(%rbp)          # r := *res * n
   movq -8(%rbp), %rax          #  %rax := r
   movq 16(%rbp), %rbx          #  %rbx := res
   movq %rax, (%rbx)            # *res = r
   fim_if:
   addq $8, %rsp                #  libera espaco alocado para r
   popq %rbp                    #  restaura %rbp
   ret
_start:
   pushq %rbp                   #  empilha %rbp                    
   movq  %rsp, %rbp             #  faz %rbp apontar para novo R.A. 
   subq $8, %rsp                # long int x (em -8(%rbp))        
   pushq $3                     #  empilha constante 3
   movq  %rbp, %rax             #  %rax := %rbp
   subq  $8, %rax               #  %rax := %rbp-8 (endereco de x)
   pushq %rax                   #  empilha endereco de x
   call fat
   addq $16, %rsp               #  libera espaco dos parametros
   movq -8(%rbp), %rdi
   movq $60, %rax
   syscall
