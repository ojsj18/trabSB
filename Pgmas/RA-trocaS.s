.section .data
    A: .quad  0
    B: .quad 0
.section .text
.globl _start
troca:
    pushq %rbp                  # empilha %rbp
    movq  %rsp, %rbp            # faz %rbp apontar para novo R.A.
    subq  $8, %rsp              # long int z (em -8(%rbp))
    movq  16(%rbp), %rax        # %rax := x
    movq (%rax), %rbx           # %rbx := end. apont. por %rax (*x)
    movq %rbx, -8(%rbp)         # z := *x
    movq  24(%rbp), %rax        # %rax := y
    movq (%rax), %rbx           # %rbx := end. apont. por %rax (*y)
    movq  16(%rbp), %rax        # %rax := x
    movq %rbx, (%rax)           # *x = *y
    movq -8(%rbp), %rbx         # %rbx := z
    movq  24(%rbp), %rax        # %rax := y
    movq %rbx, (%rax)           # *y = z
    addq $8, %rsp               # libera espaco alocado para z
    popq  %rbp                  # restaura %rbp
    ret
 _start:
    movq $1, A
    movq $2, B
    pushq $B                    # empilha endereco de B
    pushq $A                    # empilha endereco de A
    call troca
    addq $16, %rsp              # libera espaco dos parametros
    movq $0, %rdi
    movq $60, %rax
    syscall
   
