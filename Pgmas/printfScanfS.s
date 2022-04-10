.section .data                                        
    str1: .string "Digite dois numeros:\n"  
    str2: .string "%d %d"                               
    str3: .string "Os numeros digitados foram %d %d\n"   
.section .text                                      
.globl main                                          
main:                                                
   pushq %rbp                                      
   movq %rsp, %rbp                                
   subq $16, %rsp                                 
   mov $str1, %rdi               
   call printf                     
   movq %rbp, %rax                       
   subq $16, %rax                         
   movq %rax, %rdx                     
   movq %rbp, %rax                     
   subq $8, %rax                        
   movq %rax, %rsi                   
   mov $str2, %rdi                   
   call scanf                                 
   movq -16(%rbp), %rdx          
   movq -8(%rbp), %rsi           
   mov $str3, %rdi                   
   call printf                                   
   movq $60, %rax                                              
   syscall
