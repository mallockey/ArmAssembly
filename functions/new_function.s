.section .text
.global _start

_start:
    mov r0, #5
    mov r1, #10
    bl _call_me

_call_me:
    push {r4, lr}
    add r0, r0, r1
    pop {r4, pc}    