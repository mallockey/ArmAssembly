.section .text
.global _start

_start:
    mov r0, #0        @ addr
    mov r1, #4096     @ length
    mov r2, #3        @ PROT_READ | PROT_WRITE
    mov r3, #34       @ MAP_PRIVATE | MAP_ANONYMOUS
    mvn r4, #0        @ fd = -1
    mov r5, #0        @ offset
    mov r7, #192      @ mmap2 syscall
    svc #0

    str r0, [#25]


   // Exit syscall
    mov r7, #1
    mov r0, #0
    svc #0