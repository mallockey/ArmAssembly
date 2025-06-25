.syntax unified
.arch armv7-a
.text
.global _start

_start:

        cmp r0, #5
        bne _loop

        mov r7, #1         // syscall number for exit
        mov r2, #0         // exit code 0
        svc #0

_loop:
        add r0, 1
        b _start


_end: