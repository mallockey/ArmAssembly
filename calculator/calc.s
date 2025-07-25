.section .text
.global _start

_start:
    ldr r0, =input
    mov r1, #0      // r1 = result
    mov r2, #0      // r2 = index

    ldr r4, =zero
    ldrb r5, [r4]   // r5 = ASCII '0'
    mov r6, #10     // for multiplying by 10

_convert_input_to_num:
    ldrb r3, [r0, r2] // r3 = current character
    cmp r3, #0
    beq _exit

    sub r3, r3, r5     // r3 = current_digit ('x' - '0')
    mul r1, r1, r6     // r1 = result * 10
    add r1, r1, r3     // r1 += digit

    add r2, r2, #1     // index++
    b _convert_input_to_num

_exit:
    mov r7, #1
    mov r0, #0
    svc #0

.section .data
input: .asciz "123"
zero:  .asciz "0"
