# Conditional flags

There is a register in ARM CPU that tells the code what the result of the last operation was and allows the CPU to take conditional branches based off of that operation.

- Current Processor Status Register: CPSR
- Contains a series of flags that get set and cleared as a result of math operations

If we do the add operation with the S flag:

`adds r2, r0, r1`

It will add r0 + r1 it will go into r2 if certain tings in happen in the operation

## ARM Status Registers

- N (Negative)
  - Was the result of the previous operation negative?
- C (Carry)
  - Did the previous operation have an unsigned overflow?
- V (Overflow)
  - Did the previous operation have a signed overflow?
- Z (Zero)
  - Was the result of the previous operation zero?

`b[cond] dst`

## Branching

- Branch
  - Go somehwere else
  - "jump"

When you're doing a branch you're telling the PC set the program counter to this specific address or this specific offset

## Conditional Execution

`cmp r0, #16`

`bgt loop`

`movne r0, r1`
