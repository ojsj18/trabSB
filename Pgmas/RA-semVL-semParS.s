
.section .data
   A: .quad 0
   B: .quad 0
.section .text
.globl _start
soma:
   pushq %rbp                   # empilha %rbp
   movq  %rsp, %rbp
   movq  A, %rax
   movq  B, %rbx
   addq  %rax, %rbx
   movq  %rbx, %rax
   popq  %rbp                   # desempilha em %rbp
   ret                          # desempilha em %rip
_start:
   movq $4, A
   movq $5, B
   call soma                    # empilha %rip / jmp soma
   movq %rax, %rbx
   movq $60, %rax
   movq %rbx, %rdi
   syscall
