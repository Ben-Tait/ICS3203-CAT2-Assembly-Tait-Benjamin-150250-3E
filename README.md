# ICS3203-CAT2-Assembly-BenjaminTait-150250

## Overview

This repository contains solutions for the **ICS3203 CAT2 Assembly** tasks, which involve assembly language programming to perform various operations such as control flow management, array manipulation, factorial calculation, and data monitoring using port-based simulation. Each task demonstrates key concepts in low-level programming, such as memory addressing, control flow with conditional and unconditional jumps, and modular programming with subroutines.

## Task Overview

### Task 1: Control Flow and Conditional Logic

- **Objective**: Write a program that prompts for a user input number and uses branching logic to classify the number as **"POSITIVE"**, **"NEGATIVE"**, or **"ZERO"**. The program uses both conditional and unconditional jumps to handle these cases.
  
- **Key Challenges**: Understanding the correct use of conditional and unconditional jumps (`jg`, `jl`, `je`) to ensure proper program flow when classifying the number.

- **Insights**: Mastery of control flow operations in assembly (such as conditional jumps) is critical in managing program behavior based on dynamic conditions.

### Task 2: Array Manipulation with Looping and Reversal

- **Objective**: Implement a program that:
  - Accepts an array of integers from the user.
  - Reverses the array **in place** without using additional memory.
  - Outputs the reversed array.

- **Key Challenges**: Manipulating arrays directly in assembly without using extra space, ensuring proper memory handling when swapping elements.

- **Insights**: Working with arrays in assembly gives a deeper understanding of memory addressing and pointer arithmetic. The challenge lies in reversing the array without overwriting elements prematurely.

### Task 3: Modular Program with Subroutines for Factorial Calculation

- **Objective**: Develop a program that:
  - Computes the **factorial** of a number received as input.
  - Uses a separate **subroutine** to perform the calculation.
  - Manages the stack to preserve registers and demonstrate modular code organization.

- **Key Challenges**: Managing the stack correctly to preserve and restore registers when calling and returning from the subroutine.

- **Insights**: This task enhanced my understanding of modular programming in assembly and the importance of the stack for preserving state across subroutine calls. It also improved my knowledge of low-level memory management.

### Task 4: Data Monitoring and Control Using Port-Based Simulation

- **Objective**: Simulate a control program that:
  - Reads a **sensor value** from a specified memory location or input port (e.g., simulating a water level sensor).
  - Based on the input, performs actions like:
    - Turning on a motor by setting a bit in a memory location.
    - Triggering an alarm if the water level is too high.
    - Stopping the motor if the water level is moderate.

- **Key Challenges**: Simulating sensor input and controlling the motor/alarm status based on varying conditions. Manipulating memory or ports to reflect the motor or alarm status.

- **Insights**: This task provided insight into how low-level systems interact with hardware components and how simple sensors can trigger various control actions in embedded systems.

## Compilation and Execution

For each task, the process of compiling and running the program involves the following steps:

### 1. Compiling
Use the `nasm` assembler to compile the assembly code into an object file for a 64-bit system. Then, link the object file using the `ld` linker to produce an executable.

Example commands:

#### For Task 1 (Control Flow and Conditional Logic):
```bash
nasm -f elf64 -o task1.o task1.asm
ld -s -o task1 task1.o
```

#### For Task 2 (Array Manipulation with Looping and Reversal):
```bash
nasm -f elf64 -o task2.o task2.asm
ld -s -o task2 task2.o
```

#### For Task 3 (Factorial Calculation):
```bash
nasm -f elf64 -o task3.o task3.asm
ld -s -o task3 task3.o
```

#### For Task 4 (Data Monitoring and Control):
```bash
nasm -f elf64 -o task4.o task4.asm
ld -s -o task4 task4.o
```

### 2. Running the Program
After compiling, run each program using the following command:

```bash
./taskX
```
Replace X with the task number (e.g., `task1` for Task 1).

## Insights and Challenges

### Task 1: Control Flow and Conditional Logic
- **Challenges**: Understanding the correct use of conditional and unconditional jumps (`jg`, `jl`, `je`) was crucial to ensure that the program correctly classifies the number.
- **Insights**: Effective use of jump instructions is fundamental for implementing control flow in assembly language.

### Task 2: Array Manipulation with Looping and Reversal
- **Challenges**: Reversing the array in place without using additional memory required careful manipulation of indices to avoid overwriting elements prematurely.
- **Insights**: Working with arrays directly in assembly provided a deeper understanding of memory addressing and pointer arithmetic.

### Task 3: Modular Program with Subroutines for Factorial Calculation
- **Challenges**: Managing the stack to preserve registers during subroutine calls was initially complex, requiring careful handling to ensure registers are restored properly.
- **Insights**: Subroutines in assembly improve modularity and code reusability. The stack's role in saving registers is crucial for maintaining the program's state during function calls.

### Task 4: Data Monitoring and Control Using Port-Based Simulation
- **Challenges**: Simulating sensor input and controlling the system's motor and alarm status based on the sensor value was tricky.
- **Insights**: This task provided practical insight into how low-level systems interact with hardware components and trigger control actions based on sensor data.

## Conclusion

These tasks provided invaluable experience in assembly programming, challenging me to think critically about low-level system operations, including memory manipulation, control flow, and modular code design. They also helped me understand how assembly interacts with hardware components, a key skill in embedded systems programming.
