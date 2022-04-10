# Cria fd para fd_write
abre_argv_2:
   movq $OPEN_SERVICE, %rax
   movq  -0x30(%rbp), %rbx
   movq 16(%rbx), %rdi
   movq $O_CREAT, %rsi
   orq $O_WRONLY, %rsi
   movq $MODE, %rdx
   syscall
   movq %rax, -0x10(%rsp)       # salva retorno da syscall em fd_write
   cmpq $0, %rax
   jge  primeira_leitura
   movq  -0x30(%rbp), %rbx      # deu erro: imprime msg e finaliza
   movq 16(%rbx), %rsi
   movq $str2, %rdi
   call printf
   movq  $-1, -0x40(%rsp)       # saida ($?) := -1
   jmp fecha_fd_read

primeira_leitura:
   movq $READ_SERVICE, %rax
   movq -0x08(%rsp), %rdi
   movq $BUFFER, %rsi
   movq $TAM_BUFFER, %rdx
   syscall
   movq %rax, -0x18(%rsp)

while:
   cmpq $0, -0x18(%rsp)
   jle fim_pgma

# escrita
   movq $WRITE_SERVICE, %rax
   movq -0x10(%rsp), %rdi
   movq $BUFFER, %rsi
   movq -0x18(%rsp), %rdx
   syscall
   movq %rax, -0x20(%rsp)

# nova leitura
   movq $READ_SERVICE, %rax
   movq -0x08(%rsp), %rdi
   movq $BUFFER, %rsi
   movq -0x20(%rsp), %rdx
   syscall
   movq %rax, -0x18(%rsp)
   jmp while

fecha_fd_write:   
   movq $CLOSE_SERVICE, %rax
   movq -0x10(%rsp), %rdi
   syscall
   
fecha_fd_read:   
   movq $CLOSE_SERVICE, %rax
   movq -0x08(%rsp), %rdi
   syscall

fim_pgma:
   movq -0x40(%rsp), %rdi
   movq $EXIT_SERVICE, %rax
   syscall
