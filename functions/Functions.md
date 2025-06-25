# Functions

When functions are called there is an expectation that 3 things have happened

1. The arguments have come into foo
2. Foo has taken an action and returned a value through some return value
3. The state of the function that called the function is not disturbed. It must be in the exact same state.

```c
int i = 0;
foo(..);
i++;
```

## Function Basics

- Setup arguments
- "Call" vs "Jump"
  - Call preserves the function address
- Return Value
- Rerturn the program to initial state

There are a set of registers that are non-violote or preserved, they must be put in the same place as you found them.

## Setup Arguments

- "Calling Convetion"
- Arguments: r0,r1,r2,r3

`cfoo(1,2,3);`

## Call vs Jump

- Branch and Link

```s
bl foo
```

When a function is called we populate the next instruction using `bl` and that will store the next instruction in the link register

## Return

- Calling Convention
- Return Value: r0

r0 gets the first parameter of the function and the return value

```
ldr r0, #0 // Put my return value into r0
mov pv, lr // Put the link register value into the PC which lets you jump back to the caller function
```
