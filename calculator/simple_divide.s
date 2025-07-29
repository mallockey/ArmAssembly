.section .text
.global _start

_start:
    ldr r1, =test_num 
    ldr r0, [r1]       
    mov r2, #5
    mov r4, #1

_div:

    sub r0, r0, r2
    cmp r0, r2
    blt _exit

    add r4, r4, #1
    b _div

_exit:
    mov r7, #1
    mov r0, #0
    svc #0

.section .data
test_num: .word 121