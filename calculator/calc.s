.section .text
.global _start

/*
    Simple command line calculator
*/

_start:
    b _setup_string_to_int

_setup_string_to_int:
    ldr r0, =input
    mov r1, #0      // r1 = result
    mov r2, #0      // r2 = index
    ldr r4, =zero
    ldrb r5, [r4]   // r5 = ASCII '0'
    mov r6, #10 
    b _string_to_int

_string_to_int:
    ldrb r3, [r0, r2] // r3 = current character
    cmp r3, #0
    beq _exit

    sub r3, r3, r5     // r3 = current_digit ('x' - '0')
    mov r7, r1
    mul r1, r7, r6     // r1 = result * 10
    add r1, r1, r3     // r1 += digit

    add r2, r2, #1     // index++
    b _string_to_int

_setup_int_to_string:
    mov r6, #10     // for multiplying by 10
    ldr r0, =test_num
    ldr r1, [r0] // r1 = 101
    mov r2, #0 // Division Counter
    mov r11, #0
    bl _setup_div

_setup_div:
    push {lr}
    ldr r12, =converted_num
    mov r13, #0
    ldr r4, =zero
    ldrb r5, [r4] 
    b _loop_div

_loop_div:
    cmp r1, r6
    blt _div_done
    sub r1, r1, r6
    add r2, r2, #1
    b _loop_div

_div_done:
    add r1, r1, r5
    strb r1, [r12, r13]
    add r13, r13, #1

    mov r1, r2
    cmp r1, #10
    blt _append_num
    mov r2, #0
    cmp r1, r6
    beq _loop_div
    bgt _loop_div

_append_num:
    add r1, r1, r5
    strb r1, [r12, r13]
    add r13, r13, #1
    b _exit

_exit:
    mov r7, #4
    mov r0, #1
    ldr r1, =converted_num
    mov r2, r13
    svc #0
    
    mov r7, #1
    mov r0, #0
    svc #0

.section .data
input: .asciz "233444"
zero:  .asciz "0"
test_num: .word 200

.section .bss
.global num_buffer
.align 4
num_buffer:
    .skip 10
.global converted_num
.align 4
converted_num:
    .skip 40