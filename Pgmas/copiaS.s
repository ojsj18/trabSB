.section .data
str1:  .string "Copiando %s em %s\n "
str2:  .string "Erro ao abrir arquivo %s\n"

# Constantes
.equ READ_SERVICE,  0
.equ WRITE_SERVICE, 1
.equ OPEN_SERVICE,  2
.equ CLOSE_SERVICE, 3
.equ EXIT_SERVICE,  60
.equ O_RDONLY, 0000
.equ O_CREAT,  0100
.equ O_WRONLY, 0001
.equ MODE, 0600

.section .bss
.equ TAM_BUFFER, 256
.lcomm BUFFER, TAM_BUFFER

# ------- Enderecos das variaveis na pilha:
# valor saida    :      : -0x40(%rsp)
# arge           : %rdx : -0x38(%rsp)
# argv           : %rsi : -0x30(%rsp)
# argc           : %rdi : -0x28(%rsp)
# bytes_escritos : %r13 : -0x20(%rsp)
# bytes_lidos    : %r12 : -0x18(%rsp)
# fd_write       : %r11 : -0x10(%rsp)
# fd_read        : %r10 : -0x08(%rsp)

.section .text
.globl main
main:
   pushq %rbp
   movq  %rsp, %rbp
   subq  $0x80, %rsp
   movq  $0, -0x40(%rsp)

# Salva parametros argc, argv, arge
   movq  %rdi, -0x28(%rbp)      # salva argc em -0x28(%rbp)
   movq  %rsi, -0x30(%rbp)      # salva argv em -0x30(%rbp)
   movq  %rdx, -0x38(%rbp)      # salva arge em -0x38(%rbp)

# Imprime mensagem de copia (str1)
   movq  -0x30(%rbp), %rbx      # %rbx := argv
   movq 8(%rbx), %rsi           # %rsi := argv[1]
   movq  -0x30(%rbp), %rbx
   movq 16(%rbx), %rdx          # %rdi := argv[2]
   movq $str1, %rdi
   call printf

# Cria fd para fd_read
   movq $OPEN_SERVICE, %rax
   movq  -0x30(%rbp), %rbx
   movq 8(%rbx), %rdi
   movq $O_RDONLY, %rsi
   movq $MODE, %rdx
   syscall
   movq %rax, -0x08(%rsp)       # salva retorno da syscall em fd_read
   cmpq $0, %rax
   jge  abre_argv_2
   movq  -0x30(%rbp), %rbx      # deu erro: imprime msg e finaliza
   movq 8(%rbx), %rsi
   movq $str2, %rdi
   call printf
   movq  $-1, -0x40(%rsp)       # saida ($?) := -1
   jmp fim_pgma
.include "copiaS_parte2.s"
