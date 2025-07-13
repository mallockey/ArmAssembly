# Shifting Operations

- RISC architectures get power from math operations
- Optimizing code is extremely important

Shifting by the right divides the number
Shifting to the left multiples the number

Most significant bit (the largest one on the left) tells you if its negative

10110101
01011010

- Logical - Ignores the signess

10110101

01011010
When shifting to the right the signed bit will always be 0

- Arthemetic - Will acknowledge the signedness

Logical + Artihemetic are the same to the left

- Rotation - Shifts to the right and left which wraps around the number

Logical:
`lsr[s] dst, src, num`

`lsr[s] dst, src, #n`

Arithmetic:

`asr[s] dst, src, num`

Rotation:

`ror[s] dst, src, num`

`ror[s] dst, src, #n`

`lsl dst, src, #2`

`mov dst, src, LSL #2`

## Bitwise Operations

R0 = 10110101

R1 = 01011010

AND - R2 = R0&R1

R2 = 00010000

ORR - R2 = R0|R1

R0 = 10110101

R1 = 01011010

R2 = 11111111

EOR(XOR) - R2=R0^R1

R0 = 101101010

Exclusive OR means only ONE bit is on, if both are on its 0

BIC - R2 = R1 & ~R2

BIC - R2 = 10110101

BIC is basically if both bits are on turn that bit off in the destination register
