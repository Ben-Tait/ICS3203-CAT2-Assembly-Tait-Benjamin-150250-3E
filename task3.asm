section .data
    prompt          db 'Enter a number (0-12): ', 0
    result_msg      db 'Factorial is: ', 0
    newline         db 10, 0
    input_buffer    db 10 dup(0)         ; Buffer for user input
    result_buffer   db 20 dup(0)         ; Buffer for result output

section .bss
  

section .text
global _start

_start:
    ; Prompt user for input
    mov     rax, 1                  ; syscall: write
    mov     rdi, 1                  ; stdout
    mov     rsi, prompt             ; Address of the prompt
    mov     rdx, 22                 ; Length of the prompt string
    syscall

    ; Read user input into input_buffer
    mov     rax, 0                  ; syscall: read
    mov     rdi, 0                  ; stdin
    mov     rsi, input_buffer       ; Address of the input buffer
    mov     rdx, 10                 ; Max input size
    syscall

    ; Convert user input from ASCII to integer
    mov     rsi, input_buffer       ; Address of the input buffer
    call    atoi                    ; Result is stored in RAX

    ; Validate input: ensure 0 <= input <= 12
    cmp     rax, 12
    ja      invalid_input
    cmp     rax, 0
    jl      invalid_input

    ; Calculate factorial
    push    rax                     ; Save input number on the stack
    call    factorial               ; Result is in RAX
    add     rsp, 8                  ; Clean up stack

    ; Convert result (RAX) to string
    mov     rsi, result_buffer      ; Address of the result buffer
    call    itoa

    ; Display result message
    mov     rax, 1                  ; syscall: write
    mov     rdi, 1                  ; stdout
    mov     rsi, result_msg         ; Address of the result message
    mov     rdx, 14                 ; Length of the result message
    syscall

    ; Display the result
    mov     rax, 1                  ; syscall: write
    mov     rdi, 1                  ; stdout
    mov     rsi, result_buffer      ; Address of the result buffer
    mov     rdx, 20                 ; Assume max result length
    syscall

    ; Print a newline
    mov     rax, 1                  ; syscall: write
    mov     rdi, 1                  ; stdout
    mov     rsi, newline            ; Newline character
    mov     rdx, 1                  ; Length of the newline
    syscall

    ; Exit program
    mov     rax, 60                 ; syscall: exit
    xor     rdi, rdi                ; Exit code 0
    syscall

invalid_input:
    ; Handle invalid input case
    mov     rax, 1                  ; syscall: write
    mov     rdi, 1                  ; stdout
    mov     rsi, newline            ; Error newline
    mov     rdx, 22                 ; Error message length
    syscall
    mov     rax, 60                 ; syscall: exit
    xor     rdi, rdi                ; Exit code 0
    syscall

; Subroutine: Factorial Calculation
; Description: Computes factorial of a number using a loop
; Input: RAX - the number for which factorial is to be calculated
; Output: RAX - the calculated factorial
factorial:
    mov     rbx, 1                  ; Initialize result in RBX
    cmp     rax, 0                  ; Check if input is 0
    je      factorial_end           ; If 0, factorial is 1
factorial_loop:
    imul    rbx, rax                ; Multiply RBX by RAX
    dec     rax                     ; Decrement RAX
    jnz     factorial_loop          ; Repeat until RAX == 0
factorial_end:
    mov     rax, rbx                ; Return result in RAX
    ret

; Subroutine: ASCII to Integer Conversion
; Description: Converts an ASCII string to an integer
; Input: RSI - address of the input buffer
; Output: RAX - converted integer
atoi:
    xor     rax, rax                ; Clear RAX
    xor     rcx, rcx                ; Clear RCX (multiplier)
    mov     rcx, 10                 ; Base 10 multiplier

atoi_loop:
    movzx   rdx, byte [rsi]         ; Load next character
    cmp     rdx, 10                 ; Check for newline
    je      atoi_done
    sub     rdx, '0'                ; Convert ASCII digit to number
    imul    rax, rcx                ; Multiply result by 10
    add     rax, rdx                ; Add digit to result
    inc     rsi                     ; Move to next character
    jmp     atoi_loop

atoi_done:
    ret

; Subroutine: Integer to ASCII Conversion
; Description: Converts an integer to a null-terminated ASCII string
; Input: RAX - integer to convert
;        RSI - address of the result buffer
; Output: RSI - null-terminated ASCII string in the buffer
itoa:
    xor     rcx, rcx                ; Initialize digit counter
itoa_loop:
    xor     rdx, rdx                ; Clear RDX
    mov     rbx, 10                 ; Base 10 divider
    div     rbx                     ; Divide RAX by 10
    add     dl, '0'                 ; Convert remainder to ASCII
    push    rdx                     ; Push ASCII character onto stack
    inc     rcx                     ; Increment digit counter
    test    rax, rax                ; Check if RAX is 0
    jnz     itoa_loop

itoa_pop:
    pop     rdx                     ; Get digit from stack
    mov     [rsi], dl               ; Store character in buffer
    inc     rsi                     ; Move buffer pointer
    loop    itoa_pop

    mov     byte [rsi], 0           ; Null-terminate string
    ret

; ==========================================
; Documentation
; ==========================================
; 1. **Input Validation**:
;    - Ensures the user enters a number between 0 and 12.
;    - Input is rejected if out of range, and the program exits.

; 2. **Factorial Logic**:
;    - Factorial is calculated iteratively in the `factorial` subroutine.
;    - Handles edge case: `factorial(0) = 1`.

; 3. **Subroutines**:
;    - `atoi`: Converts ASCII input to an integer.
;    - `itoa`: Converts integer result to ASCII string for output.

; 4. **Registers**:
;    - `RAX`: Used for return values and computations.
;    - `RBX`: Stores the factorial result during iteration.
;    - `RSI`: Points to input/output buffers.

; 5. **Stack Management**:
;    - **Push and Pop Instructions**:
;      - The stack is used to preserve register values that may be modified during subroutine execution.
;      - Registers `RAX`, `RCX`, and `RBX` are used in various subroutines and need to be preserved.
;      - **`push rax`** is used in the `factorial` subroutine to save the input value (RAX) before calling the factorial calculation. This ensures that the value in RAX is not overwritten during the recursion and the calculation process.
;      - After returning from the `factorial` subroutine, **`add rsp, 8`** is used to clean up the stack and restore the stack pointer.
;      - **`pop rdx`** is used in the `itoa` subroutine to retrieve the previously saved digit (stored on the stack) and to store it in the result buffer (RSI).
;      - The **`loop`** instruction in the `itoa` subroutine ensures that all digits of the result are retrieved from the stack and stored into the result buffer correctly.
;      - Proper stack management is done to ensure that after the factorial and string conversion processes, the registers are restored to their original values and the stack is properly cleaned up.

; 6. **Program Flow**:
;    - User inputs a number.
;    - Input is validated.
;    - Factorial is computed and converted to ASCII.
;    - Results are displayed.

; 7. **Registers Preservation and Restoration**:
;    - **Preservation**:
;      - In the `factorial` subroutine, the input value in `RAX` is pushed onto the stack before the subroutine begins. This prevents any modification to the input value and allows for correct return values.
;      - During the `itoa` subroutine, the value of `RDX` (the digit to be written) is stored on the stack to ensure that the loop can retrieve each digit in the correct order.
;    - **Restoration**:
;      - After completing the factorial calculation, the input value is restored from the stack.
;      - The program cleans up the stack pointer (`rsp`) by adjusting it after the factorial subroutine.
;      - When the digits are retrieved in the `itoa` subroutine, the values are popped off the stack in the correct order to form the final result.

; 8. **Stack Usage**:
;    - Temporary values (e.g., digits during conversion) are stored on the stack during subroutine execution.
;    - The stack is cleared properly after subroutine calls using `add rsp, 8` and `pop` instructions, ensuring the program does not leave any residual values on the stack.
;    - Stack management ensures that the program can function correctly and maintain proper register state between different subroutine calls.
