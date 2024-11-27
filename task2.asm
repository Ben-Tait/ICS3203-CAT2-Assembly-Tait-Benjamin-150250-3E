section .data
    prompt db "Enter a single digit (0-9): ", 0       ; Prompt to ask the user for input
    prompt_len equ $ - prompt                         ; Length of the prompt string
    newline db 10                                     ; Newline character for printing
    invalid_input_msg db "Invalid input! Please enter a digit (0-9).", 0   ; Error message for invalid input
    invalid_input_len equ $ - invalid_input_msg       ; Length of the invalid input message

section .bss
    array resb 5    ; Reserve 5 bytes for the array to store digits
    input resb 2    ; Reserve 2 bytes for the input buffer (character + newline)

section .text
    global _start

_start:
    ; Initialize array index (counter for storing digits in the array)
    xor r12, r12    ; Clear r12 register to use it as an index (0 to 4)

input_loop:
    ; Print prompt to ask for a digit
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; Read input from user
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 2
    syscall

    ; Validate if the input is a digit (0-9)
    mov al, [input]
    cmp al, '0'
    jl invalid_input
    cmp al, '9'
    jg invalid_input

    ; Store valid digit in the array
    mov [array + r12], al
    inc r12

    ; Check if all 5 digits have been collected
    cmp r12, 5
    jl input_loop

    ; Reverse the array in place
    mov r12, 0      ; Left index
    mov r13, 4      ; Right index

reverse_loop:
    cmp r12, r13
    jge print_array ; Exit if indices have crossed

    ; Swap elements at r12 and r13
    mov al, [array + r12]
    mov bl, [array + r13]
    mov [array + r12], bl
    mov [array + r13], al

    ; Move indices towards the center
    inc r12
    dec r13
    jmp reverse_loop

print_array:
    mov r12, 0      ; Reset index for printing

print_loop:
    mov al, [array + r12]
    mov [input], al

    ; Print the character
    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, 1
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Increment index and check if done
    inc r12
    cmp r12, 5
    jl print_loop

exit:
    mov rax, 60     ; Exit system call
    xor rdi, rdi    ; Exit status 0
    syscall

invalid_input:
  
    mov rax, 1
    mov rdi, 1
    mov rsi, invalid_input_msg
    mov rdx, invalid_input_len
    syscall
    jmp input_loop


; ========================================================================
; Documentation:
; ========================================================================
; 1. **Input Handling:**
;    - The program prompts the user to input a single digit (0-9) repeatedly until five valid digits are collected.
;    - The validation ensures the input falls within the ASCII range for digits ('0' to '9').
;    - Invalid inputs result in an error message and a restart of the input process.
;
; 2. **Reversal Logic:**
;    - The reversal is performed in place using two indices:
;        - `r12` starts at the beginning of the array (left index).
;        - `r13` starts at the end of the array (right index).
;    - Elements at the left and right indices are swapped iteratively, and the indices move towards the center.
;    - The loop terminates when the left index is greater than or equal to the right index.
;
; 3. **Printing:**
;    - After reversal, the program prints each character in the reversed array.
;    - A newline character is printed after each digit for clarity.
;
; 4. **Challenges and Solutions:**
;    - **Memory Management:** Direct access to memory addresses requires careful index handling to prevent out-of-bounds errors.
;    - **In-place Reversal:** The swapping process ensures no additional memory is used while reversing the array.
;    - **Error Handling:** Invalid input is gracefully handled by restarting the input loop and ensuring the program collects exactly five valid digits.
;
; 5. **Exit:**
;    - The program exits gracefully using the `sys_exit` system call.
;
; ========================================================================
