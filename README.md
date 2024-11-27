# ICS3203-CAT2-Assembly-<YourName and Admn Number>

## Overview

This repository contains the solutions for the Assembly Language tasks in the ICS3203 course at Strathmore University. The primary goal of these tasks is to practice core concepts in low-level programming using x86-64 assembly language. The tasks cover various aspects of assembly, including control flow, conditional logic, array manipulation, modular programming with subroutines, and data monitoring/control using port-based simulations.

Each task has been carefully implemented and commented on to demonstrate the usage of assembly constructs and to provide insights into the challenges encountered during implementation.

---

## Tasks

### 1. [Control Flow and Conditional Logic](#task-1-control-flow-and-conditional-logic)
- **Purpose**: Write a program that prompts the user for a number and classifies it as “POSITIVE,” “NEGATIVE,” or “ZERO” using conditional and unconditional jumps.
- **Key Concepts**: Conditional jumps (`jg`, `jl`, `je`) and unconditional jumps (`jmp`) in assembly.

### 2. [Array Manipulation with Looping and Reversal](#task-2-array-manipulation-with-looping-and-reversal)
- **Purpose**: Implement a program that accepts an array of integers, reverses the array in place, and outputs the reversed array.
- **Key Concepts**: Arrays, loops, memory manipulation, and avoiding extra space usage.

### 3. [Modular Program with Subroutines for Factorial Calculation](#task-3-modular-program-with-subroutines-for-factorial-calculation)
- **Purpose**: Develop a program that computes the factorial of a number using a subroutine. The program demonstrates modular programming with stack operations to preserve registers.
- **Key Concepts**: Subroutines, factorial computation, stack operations, and register preservation.

### 4. [Data Monitoring and Control Using Port-Based Simulation](#task-4-data-monitoring-and-control-using-port-based-simulation)
- **Purpose**: Simulate a control program that reads a sensor value, and based on the value, controls a motor and alarm system.
- **Key Concepts**: Simulating sensor data, control flow based on sensor readings, and manipulating motor/alarm status.

---

## Instructions on Compiling and Running the Code

### Prerequisites:
- **Assembler**: `nasm` (Netwide Assembler) version 2.15.05 or later
- **Linker**: `ld` (GNU Linker)
- **Operating System**: Linux or other Unix-like OS (Ubuntu is preferred)

### To Compile Each Program:

1. Clone the repository to your local machine.
2. Navigate to the directory containing the `.asm` file for the task you want to compile.
3. Open a terminal and use the following commands:

   **For Task 1 (Control Flow and Conditional Logic)**:
   ```bash
   nasm -f elf64 -o task1.o task1.asm
   ld -s -o task1 task1.o
   ./task1
### For Task 2 (Array Manipulation with Looping and Reversal):

```bash
nasm -f elf64 -o task2.o task2.asm
ld -s -o task2 task2.o
./task2
For Task 3 (Modular Program with Subroutines for Factorial Calculation):
bash
Copy code
nasm -f elf64 -o task3.o task3.asm
ld -s -o task3 task3.o
./task3
For Task 4 (Data Monitoring and Control Using Port-Based Simulation):
bash
Copy code
nasm -f elf64 -o task4.o task4.asm
ld -s -o task4 task4.o
./task4
Running the Program:
After compiling, run each program using ./taskX, where X is the task number (e.g., task1 for Task 1).

Insights and Challenges Encountered
Task 1: Control Flow and Conditional Logic
Challenges: Understanding the correct use of conditional and unconditional jumps was key to ensuring the program flows correctly. I had to pay close attention to the conditions to classify the input number as positive, negative, or zero.
Insight: The ability to use jg, jl, and je effectively in assembly is crucial for implementing control flow logic.
Task 2: Array Manipulation with Looping and Reversal
Challenges: Reversing the array in place without using additional memory was tricky. I had to make sure to manipulate the indices correctly, taking care of potential overwriting.
Insight: Working with arrays directly in assembly requires a deep understanding of memory addressing and pointer arithmetic.
Task 3: Modular Program with Subroutines for Factorial Calculation
Challenges: Managing the stack to preserve registers and calling the subroutine was initially complex. I had to ensure that the factorial function preserved and restored the registers properly.
Insight: Using subroutines in assembly is an excellent way to break down complex tasks and improve code modularity. The stack's role in saving registers made me appreciate low-level memory management.
Task 4: Data Monitoring and Control Using Port-Based Simulation
Challenges: Simulating sensor input and controlling the motor/alarm status based on varying conditions was a bit challenging. I had to understand how to simulate the sensor value and how changes in the status variables reflect on the system's behavior.
Insight: This task provided insight into how low-level systems interact with hardware components, and how simple sensors can trigger various control actions in embedded systems.
Conclusion
These tasks provided invaluable experience in working with assembly language, highlighting its use in manipulating control flow, memory, and registers. The exercises challenged my understanding of low-level system programming and gave me hands-on experience in managing hardware-like behavior and control mechanisms.
