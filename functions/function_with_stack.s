.section .text
.global _start

_start:
        ldr r0, =#1
        ldr r1, =#2
        bl foo
        mov r0, r0

        // Exit syscall
        mov r7, #1
        mov r0, #0
        svc #0

foo:
        push {r4-r11, lr}
        sub sp, sp, #32

        add r0, r0, r1

        add sp, sp, #32
        pop {r4-r11, pc}