.section .text
.global _start

_start:
        ldr r0, =#1
        ldr r1, =#2
        bl foo
        mov r0, r0

foo:

        push {r4-r11, lr}
        sub sp, sp, #32

        cmp r0, #5
        beq foo_end

        add r0, r0, #1
        bl foo


foo_end:
        add sp, sp, #32
        pop {r4-r11, pc}