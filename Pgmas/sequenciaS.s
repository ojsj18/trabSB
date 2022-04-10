 .section .data
    A: .quad 0
 .section .text
 .globl _start
 _start:
    movq $0x123456789abcdef,%rcx  # instrucao 1
    movq %rcx, A                  # instrucao 2
    movq $60, %rax
    movq $13, %rdi
    syscall
