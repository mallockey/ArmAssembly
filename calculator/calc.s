.section .text
.global _start

/*
    Simple command line calculator
*/

_start:
    bl _get_input
    bl _set_input_vars
    ldr r0, = [operand1]    
    bl _setup_string_to_int
    push {r1}
    ldr r0, = [operand2]    
    bl _setup_string_to_int
    push {r1}
    pop {r0, r1}
    bl _operate_on_numbers
    mov r0, r5
    bl _setup_int_to_string
    b _output_num    

_get_input:
    push {lr}
    mov r7, #3
    mov r0, #0
    ldr r1, =input_buffer
    mov r2, #256
    svc #0
    pop {pc}

_set_input_vars:
    push {lr}
    mov r0, #0 // input count read
    mov r4, #0 // current count operand read
    ldr r3, =operand1
    b _loop_read_input_operand_1

_loop_read_input_operand_1:
    ldrb r2, [r1, r0]

    cmp r2, #32 // " "
    beq _skip_white_space

    cmp r2, #42 // *
    beq _setup_read_input_operand_2
    cmp r2, #43 // +
    beq _setup_read_input_operand_2
    cmp r2, #45 // -
    beq _setup_read_input_operand_2
    cmp r2, #47 // /
    beq _setup_read_input_operand_2

    strb r2, [r3, r4]

    add r0, r0, #1
    add r4, r4, #1

    b _loop_read_input_operand_1

_skip_white_space:
    add r0, r0, #1
    b _loop_read_input_operand_1

_setup_read_input_operand_2:
    // first add the operator
    mov r4, #0
    ldr r3, =operator
    strb r2, [r3, r4]


    // setup operand2
    add r0, r0, #1
    ldr r3, =operand2
    mov r4, #0
    b _loop_set_input_operand_2

_loop_set_input_operand_2:
    ldrb r2, [r1, r0]

    cmp r2, #0
    beq _all_inputs_set

    cmp r2, #10
    beq _all_inputs_set

    cmp r2, #32
    beq _skip_white_space_2
    
    strb r2, [r3, r4]

    add r0, r0, #1
    add r4, r4, #1

    b _loop_set_input_operand_2

_skip_white_space_2:
    add r0, r0, #1
    b _loop_set_input_operand_2

_all_inputs_set:
    pop {pc}

_setup_string_to_int:
    @ ldr r0, =input
    push {lr}
    mov r1, #0      // r1 = result
    mov r2, #0      // r2 = index
    ldr r4, =zero
    ldrb r5, [r4]   // r5 = ASCII '0'
    mov r6, #10 
    b _string_to_int

_string_to_int:
    ldrb r3, [r0, r2] // r3 = current character
    cmp r3, #0
    beq _string_to_int_done

    sub r3, r3, r5     // r3 = current_digit ('x' - '0')
    mov r7, r1
    mul r1, r7, r6     // r1 = result * 10
    add r1, r1, r3     // r1 += digit

    add r2, r2, #1     // index++
    b _string_to_int

_string_to_int_done:
    pop {pc}

_setup_int_to_string:
    push {lr}
    mov r6, #10     // for multiplying by 10
    @ ldr r0, =test_num
    mov r1, r0 // r1 = 101
    mov r2, #0 // Division Counter
    @ mov r11, #0
    bl _setup_div

_setup_div:
    ldr r12, =converted_num
    mov r11, #0
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
    strb r1, [r12, r11]
    add r11, r11, #1

    mov r1, r2
    cmp r1, #10
    blt _append_num
    mov r2, #0
    cmp r1, r6
    beq _loop_div
    bgt _loop_div

_append_num:
    add r1, r1, r5
    strb r1, [r12, r11]
    add r11, r11, #1
    pop {pc}
    @ b _exit

_operate_on_numbers:
    push {lr}
    ldr r2, =operator
    mov r4, #0
    ldrb r3, [r2, r4]

    cmp r3, #42 // *
    beq _multiply
    cmp r3, #43 // +
    beq _add
    cmp r3, #45 // -
    beq _subtract
    cmp r3, #47 // /
    beq _setup_divide

_add:
    add r5, r1, r0 
    pop {pc}

_subtract:
    sub r5, r1, r0
    pop {pc}

_multiply:
    mul r5, r1, r0
    pop {pc}

_setup_divide:
    mov r5, #0
    b _loop_divide

_loop_divide:
    cmp r1, r0
    blt _done_divide

    sub r1, r1, r0

    add r5, r5, #1
    b _loop_divide

_done_divide:
    pop {pc}

_output_num:

    bl _setup_normal_num

    mov r5, #10
    add r4, r4, #1
    strb r5 , [r3, r4]
    add r11, r11, #2

    mov r7, #4
    mov r0, #1
    ldr r1, =forward_num
    mov r2, r11
    svc #0

    mov r0, #0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0
    mov r11, #0
    mov r12, #0

    ldr r1, =forward_num
    str r0, [r1]

    ldr r1, =num_buffer
    str r0, [r1]

    ldr r1, =converted_num
    str r0, [r1]

    ldr r1, =operand1
    str r0, [r1]

    ldr r1, =operand2
    str r0, [r1]

    ldr r1, =operator
    str r0, [r1]

    b _start
    
    //exit
    mov r7, #1
    mov r0, #0
    svc #0

_setup_normal_num:
    push {lr}
    ldr r1, =converted_num
    mov r2, r11
    subs r2, r11, #1
    ldr r3, =forward_num
    mov r4, #0

_loop_normal_num:

    ldrb r5, [r1, r2]

    cmp r2, #0
    blt _normal_num_done

    strb r5 , [r3, r4]

    add r4, r4, #1
    sub r2, r2, #1

    b _loop_normal_num

_normal_num_done:
    pop {pc}

.section .data
zero:  .asciz "0"

.section .bss
.global num_buffer
.align 4
num_buffer:
    .skip 10
.global converted_num
.align 4
forward_num:
.global forward_num
.align 4
    .skip 256
converted_num:
    .skip 40
input_buffer:
    .skip 256
operand1:
    .skip 256
operand2:
    .skip 256
operator:
    .skip 1