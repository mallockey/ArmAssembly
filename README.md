# ARM Assembly

## Registers

General Purpose

- `r0-r10` - do whatever you want

Calling Convention

- `r0-r3, r7` - has specific use cases

### Special Purpose

- r11: Frame Pointer - points to the bottom of the stack frame
- r12: Intra Procedure Call - register that is general purpose (sort of) and its purpose is to put data between function calls
- r13: Stack Pointer - top of the stack
- r14: Link Register - the pointer to return to when a function call ends where to go back to
- r15: Program Counter - register that contains the next instruction
- CPSR - Current Program State

Basic commands

- `mov` - move some value into a register. Ex: `mov r0, pc`
- `sub` - subtract a value and store it in a register ex: `sub r0, r0, #8`

## Load Operations

A load operation is an instruction in the ARM CPU archietecture that loads a value into a register.

Syntax: `ldr dst, #value`

The `ldr` instruction set can only be up to 32 bits. If you wanted to run a load a 32 bit value into

`ldr dst, =#value`

- `movw r0, #value_bottom` - moves the bottom

- `movt r0, #value_top` - moves to the top

ldr dst, [src]

Hard brackets `[]` get the memory located at

`ldr r0, [pc, #12]`

ldr dst

## Store Operations

Store data

`str src, [dst]`
