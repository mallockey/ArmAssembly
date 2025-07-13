# Operating Systems

<b>Kernel:</b> The core of the operating system that manages system resources and hardware. it handles process management, memory management, device management and system calls.

<b>System Calls:</b> Interfaces provided by the OS to allow user applications to request services from the kernel, such as file operations, process control, and communication

<b>File System:</b> Manages files and directories, providing a way to store, retrieve, and organize data.

<b>Process Management:</b> Manages the creation, scheduling, and termination of processes, allowing multiple programs to run concurrently.

<b>Memory Managmenet:</b> Manages system memory, including allocation, deallocation, and swapping between physical memory and disk storage.

<b>Device Drivers:</b> Interface with hardware devices, providing abstraction and control for peripherals such as disks, keyboards, and network interfaces.

## ARM Exception Levels

- EL0
  - "User land" - all of our code has been here
- EL1
  - "Kernel mode" - all of the operating system happens here
- EL2 + EL3
  - Not in the scope of this course

## System Call

Basically an API to ask the kernel to do more

## Syscalls

`svc #0` - CPU gets interrputed it runs the sys call interrput which points into the kernel and then the kernal has a function that handles it

R7 must contain the syscall number

r0 - r5
arguments to the syscall
