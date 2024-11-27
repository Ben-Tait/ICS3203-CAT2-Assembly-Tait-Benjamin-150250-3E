# ICS3203-CAT2-Assembly-BenjaminTait-150250

## Overview

This repository contains the solutions for the Assembly Language tasks in the ICS3203 course at Strathmore University. The primary goal of these tasks is to practice core concepts in low-level programming using x86-64 assembly language. 
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
