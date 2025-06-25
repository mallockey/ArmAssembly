.syntax unified
.arch armv7-a
.global _start
.section .text

_start:
        ldr r7, =#5
        ldr r0, =filename
        mov r1, #0x241          
        mov r2, #420 
        svc #0

        ldr r7, =#4
        ldr r1, =buff
        ldr r2, =#13            
        svc #0


.section .data
buff:
        .asciz "Hello, world!"

filename:
        .asciz "output.txt"