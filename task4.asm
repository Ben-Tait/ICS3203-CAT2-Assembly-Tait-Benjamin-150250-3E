global _start

section .data
    sensor_value    dd 0        ; Simulated sensor input
    motor_status    db 0        ; Motor status: 0=OFF, 1=ON
    alarm_status    db 0        ; Alarm status: 0=OFF, 1=ON

    HIGH_LEVEL      equ 80
    MODERATE_LEVEL  equ 50

    prompt          db 'Enter sensor value: ', 0
    input_buffer    db 10 dup(0)
    motor_msg       db 'Motor Status: ', 0
    alarm_msg       db 'Alarm Status: ', 0
    on_msg          db 'ON', 10, 0
    off_msg         db 'OFF', 10, 0

section .bss
    ; Uninitialized data section

section .text
_start:
    ; ==========================================
    ; Prompt for sensor value
    ; ==========================================
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, prompt
    mov     rdx, 20                 ; Length of the prompt
    syscall

    ; ==========================================
    ; Read user input (sensor value)
    ; ==========================================
    mov     rax, 0                  ; sys_read
    mov     rdi, 0                  ; stdin
    mov     rsi, input_buffer
    mov     rdx, 10
    syscall

    ; ==========================================
    ; Convert input to integer (ASCII to int)
    ; ==========================================
    mov     rsi, input_buffer
    call    atoi                    ; Result in RAX

    ; ==========================================
    ; Store sensor value in memory
    ; ==========================================
    mov     [sensor_value], eax

    ; ==========================================
    ; Read the sensor value
    ; ==========================================
    mov     eax, [sensor_value]

    ; ==========================================
    ; Determine actions based on sensor value
    ; ==========================================
    cmp     eax, HIGH_LEVEL
    jg      high_level

    cmp     eax, MODERATE_LEVEL
    jg      moderate_level

low_level:
    ; Low level: Motor ON, Alarm OFF
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 0
    jmp     display_status

moderate_level:
    ; Moderate level: Motor OFF, Alarm OFF
    mov     byte [motor_status], 0
    mov     byte [alarm_status], 0
    jmp     display_status

high_level:
    ; High level: Motor ON, Alarm ON
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 1

display_status:
    ; ==========================================
    ; Display motor status
    ; ==========================================
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, motor_msg
    mov     rdx, 14
    syscall

    mov     al, [motor_status]
    cmp     al, 1
    je      motor_on
    jmp     motor_off

motor_on:
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, on_msg
    mov     rdx, 3
    syscall
    jmp     display_alarm

motor_off:
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, off_msg
    mov     rdx, 4
    syscall

display_alarm:
    ; ==========================================
    ; Display alarm status
    ; ==========================================
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, alarm_msg
    mov     rdx, 13
    syscall

    mov     al, [alarm_status]
    cmp     al, 1
    je      alarm_on
    jmp     alarm_off

alarm_on:
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, on_msg
    mov     rdx, 3
    syscall
    jmp     exit_program

alarm_off:
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    mov     rsi, off_msg
    mov     rdx, 4
    syscall

exit_program:
    ; ==========================================
    ; Exit the program
    ; ==========================================
    mov     rax, 60                 ; sys_exit
    xor     rdi, rdi
    syscall

; ==========================================
; Subroutine: ASCII to Integer Conversion (atoi)
; ==========================================
atoi:
    xor     rax, rax                ; Clear RAX
    xor     rbx, rbx                ; Clear RBX for temporary storage
    mov     rbx, 10                 ; Multiplier (base 10)

atoi_loop:
    movzx   rcx, byte [rsi]         ; 
    cmp     rcx, 10                 ; Check for newline
    je      atoi_done
    sub     rcx, '0'                ; Convert ASCII to digit
    imul    rax, rbx                ; Multiply current value by 10
    add     rax, rcx                ; Add digit to result
    inc     rsi
    jmp     atoi_loop

atoi_done:
    ret

; ==========================================
; Documentation
; ==========================================
; 1. **Sensor Input**:
;    - The program simulates a water level sensor by reading a "sensor value" from a user input (via stdin).
;    - The sensor value is entered by the user and is then converted from ASCII to an integer using the `atoi` subroutine.
;    - The value is stored in the `sensor_value` memory location (4 bytes, represented as `dd` in the .data section).

; 2. **Actions Based on Sensor Value**:
;    - The program compares the sensor value to predetermined thresholds (`HIGH_LEVEL` = 80, `MODERATE_LEVEL` = 50) to determine which actions to take:
;      - **High Level (greater than 80)**: 
;        - The motor is turned **ON** (by setting the `motor_status` byte to `1`).
;        - The alarm is also triggered **ON** (by setting the `alarm_status` byte to `1`).
;      - **Moderate Level (greater than 50 but less than or equal to 80)**: 
;        - The motor is turned **OFF** (by setting the `motor_status` byte to `0`).
;        - The alarm remains **OFF** (by setting the `alarm_status` byte to `0`).
;      - **Low Level (less than or equal to 50)**: 
;        - The motor is turned **ON** (by setting the `motor_status` byte to `1`).
;        - The alarm is turned **OFF** (by setting the `alarm_status` byte to `0`).
;    - These decisions are based on comparisons using the `cmp` and `jg` (jump if greater) instructions in the program.

; 3. **Memory Manipulation**:
;    - **`motor_status`** and **`alarm_status`** are byte-sized variables stored in the `.data` section of memory:
;      - **`motor_status`**: A byte that controls the motor's state. A value of `1` means the motor is ON, and `0` means the motor is OFF.
;      - **`alarm_status`**: A byte that controls the alarm's state. A value of `1` means the alarm is ON, and `0` means the alarm is OFF.
;    - These values are set in response to the sensor input, directly affecting the system's behavior.

; 4. **Subroutine: Displaying Motor and Alarm Status**:
;    - Once the program determines the action to take based on the sensor value, it then displays the current motor and alarm status to the user.
;    - The `sys_write` syscall is used to output the motor and alarm status to the screen.
;    - The program uses the `on_msg` and `off_msg` strings to display whether the motor or alarm is ON or OFF, based on the current values of `motor_status` and `alarm_status`.

; 5. **Flow of Execution**:
;    - **Step 1**: The program prompts the user to input the sensor value.
;    - **Step 2**: The program reads the input, converts it from ASCII to an integer, and stores it in `sensor_value`.
;    - **Step 3**: The sensor value is compared against the threshold values to determine the motor and alarm states.
;    - **Step 4**: The motor and alarm status are displayed using the `sys_write` syscall.
;    - **Step 5**: The program exits gracefully.

; 6. **Program Termination**:
;    - The program terminates with the `sys_exit` syscall after displaying the motor and alarm statuses.

; 7. **Registers and Stack**:
;    - **RAX**: Used for returning values (converted sensor input value, etc.).
;    - **RSI**: Points to the input buffer when reading from stdin or when displaying messages.
;    - **RDI**: Used to specify the file descriptor for `sys_write` (stdout or stdin).
;    - **RDX**: Specifies the length of the data to be written (for messages).
;    - **RSP (Stack)**: Used to store intermediate values such as the converted digits during the `atoi` conversion subroutine.
;    - The program uses the stack for temporary storage of values but does not heavily rely on it due to the simplicity of the operations.

; 8. **Summary of Actions Based on Sensor Input**:
;    - **High Sensor Value** (greater than 80): 
;        - Motor is turned ON (Set `motor_status = 1`).
;        - Alarm is triggered ON (Set `alarm_status = 1`).
;    - **Moderate Sensor Value** (greater than 50 but less than or equal to 80):
;        - Motor is turned OFF (Set `motor_status = 0`).
;        - Alarm remains OFF (Set `alarm_status = 0`).
;    - **Low Sensor Value** (less than or equal to 50):
;        - Motor is turned ON (Set `motor_status = 1`).
;        - Alarm is turned OFF (Set `alarm_status = 0`).

