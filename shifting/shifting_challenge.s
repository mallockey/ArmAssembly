.section .text
.global _start

_start:
        ldr r1, =input
        ldr r2, [r1]
        lsr r0, r2, #28

        lsr r1, r2, #24
        and r1, r0, #0xF

        lsr r3, r2, #20
        and r3, r0, #0xF

        lsr r4, r2, #16
        and r4, r0, #0xF

        ror r0, #1
        ldr r5, =b0
        str r0, [r5]

        ror r1, #1
        ldr r5, =b1
        str r1, [r5]

        ror r3, #1
        ldr r5, =b2
        str r3, [r5]

        ror r4, #1
        ldr r5, =b3
        str r4, [r5]

.section .data
input:  .word 0xDEADBEEF   @ Raw 32-bit number

b0: .word 0
b1: .word 0
b2: .word 0
b3: .word 0