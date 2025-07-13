.section .text
.global _start

_start:
    bl _main
    b _exit

_main:
    bl display_prompt
    bl _read_input
    bl _fork
    b _main

// Display

display_prompt:
    push {lr}
    ldr r0, =shell_prompt
    bl print_string
    pop {pc}

print_string:
    push {lr}
    mov r1, r0
    bl _print_loop
    pop {pc}

_print_loop:
    push {lr}
    mov r4, r1
    mov r2, #0

.loop:
   ldrb r3, [r1, r2]
   cmp r3, #0
   beq .done
   add r2, r2, #1
   b .loop

.done:
   mov r0, #1
   mov r1, r4
   mov r2, r2
   mov r7, #4
   svc #0
   pop {pc}


// Prompt

_read_input:
    push {r0-r2, lr}
    mov r7, #3
    mov r0, #0
    ldr r1, =input
    mov r2, #20
    svc #0
    pop {r0-r2, pc}

_fork:
    mov r7, #2
    svc #0
    cmp r0, #0
    beq _prepare_construct_command
    bne _wait

_wait:
    ldr r1, =child_status
    mov r7, #7
    svc #0

    bl _print_newline
    b _main

_print_newline:
    push {lr}
    mov r0, #1
    ldr r1, =new_line
    mov r2, #1          @ Just 1 byte: '\n'
    mov r7, #4
    svc #0
    pop {pc}


_prepare_construct_command:
    ldr r0, =command_to_run
    ldr r1, =command_prepend
    mov r2, #0
    b _construct_command

_construct_command:
    ldrb r3, [r1, r2]
    cmp r3, #0
    beq _setup_user_input
    strb r3, [r0, r2]
    add r2, r2, #1
    b _construct_command

_setup_user_input:
    ldr r1, =input
    ldr r4, =#0
    b _add_user_input

_add_user_input:
    ldrb r3, [r1, r4]
    cmp r3, #0     // null terminated
    beq _call_the_command

    cmp r3, #10     // new line
    beq _call_the_command

    cmp r3, #32 // space (look for arguments)
    beq _get_arguments

    strb r3, [r0, r2]
    add r2, r2, #1
    add r4, r4, #1
    b _add_user_input

_get_arguments:
    ldr r1, =arguments
    ldr r4, =#0
    b _add_user_arguments

_add_user_arguments:
    ldrb r3, [r1, r4]
    cmp r3, #0     // null terminated
    beq _call_the_command

    cmp r3, #10     // new line
    beq _call_the_command
    
    strb r3, [r0, r2]
    add r4, r4, #1
    b _add_user_arguments


_call_the_command:
    ldr r0, =command_to_run
    ldr r1, =arguments
    mov r2, #0
    mov r7, #11
    svc #0
    b _exit

_exit:
    mov r7, #1
    mov r0, #0
    svc #0

.section .data
    shell_prompt:
        .asciz "$/"

    command_prepend:
        .asciz "/bin/"
        
    new_line:
        .asciz "\n"

.section .bss

.global input
.align 4
input:
    .skip 256

.global command_to_run
.align 4
command_to_run:
    .skip 256

.global arguments
.align 4
arguments:
    .skip 256

.global child_status
.align 4
child_status:
    .skip 4

.global child_process_id
.align 4
child_process_id:
    .skip 4