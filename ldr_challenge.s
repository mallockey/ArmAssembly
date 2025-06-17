.syntax unified
.arch armv7-a
.section .text
.global _start

_start:
    ldr r0, =mydata
    ldm r0, {r1, r2, r3, r4, r5, r6, r7, r8}

    mov r9, r1
    add r9, r3
    add r9, r5
    add r9, r7

    ldr r10, = result
    str r9, [r10]

    // Exit syscall
    mov r7, #1
    mov r0, #0
    svc #0

.section .data
mydata:
    .word 10, 20, 30, 40, 50, 60, 70, 80

result:
    .word 0