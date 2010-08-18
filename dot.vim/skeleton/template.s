.section .data

.section .bss

.section .text
.globl _start
_start:




# exit
    movl $1, %eax
    movl $0, %ebx
    int $0x80
