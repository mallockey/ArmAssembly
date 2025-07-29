.section .text
.global _start

_start:
    @ ldr r0, =input
    @ mov r1, #0      // r1 = result
    @ mov r2, #0      // r2 = index

    @ ldr r4, =zero
    @ ldrb r5, [r4]   // r5 = ASCII '0'
    mov r6, #10     // for multiplying by 10
    ldr r0, =test_num
    ldr r1, [r0]
    mov r2, #1
    b _convert_int_to_string

_convert_input_to_num:
    ldrb r3, [r0, r2] // r3 = current character
    cmp r3, #0
    beq _exit

    sub r3, r3, r5     // r3 = current_digit ('x' - '0')
    mul r1, r2, r6     // r1 = result * 10
    add r1, r1, r3     // r1 += digit

    add r2, r2, #1     // index++
    b _convert_input_to_num

_convert_int_to_string:
    bl _div
    // Need to increment to next char
    mul r3, r1, r6
    sub r4, r0, r3

    cmp r1, #0
    beq _exit
    @ ldr r0, r1
    b _convert_int_to_string    

_div:
    push {lr}
    sub r1, r1, r6
    cmp r1, r6
    blt _div_done

    add r2, r2, #1
    b _div

_div_done:
    pop {lr}

_exit:
    mov r7, #1
    mov r0, #0
    svc #0

.section .data
input: .asciz "123"
zero:  .asciz "0"
test_num: .word 100