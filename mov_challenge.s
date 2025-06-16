.syntax unified
.arch armv7-a
.section .text
.global _start

_start:
    // Step 1: Load 0xBEEF1337 into r0 using movw/movt
    // Step 2: Load 0x12345678 into r1 using ldr + literal pool
    // Step 3: Exit syscall

    // Your code goes here...
    movw r0, 0x1337
    movt r0, 0xBEEF
    ldr r1, [pc, #16]
    movw r3, 0x1337
    movw r3, 0x1337
    mov r7, #1         // syscall number for exit
    mov r2, #0         // exit code 0
    svc #0

// Step 2: literal pool value goes here
.word 0x12345678