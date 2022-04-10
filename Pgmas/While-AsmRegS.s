 .section .text                         
 .globl _start                         
 _start:                               
    movq $0, %rax                # %rax contem I                       
    movq $0, %rdi                # %rdi contem A          
while:                             
    cmpq $10, %rax               
    jge fim_while            
    addq %rax, %rdi              
    addq $1, %rax                
    jmp while                
fim_while:                 
    movq $60, %rax                  
    syscall
