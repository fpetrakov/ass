TIME equ 40

section .text
default rel
global expected_minutes_in_oven
expected_minutes_in_oven:
    mov rax, TIME
    ret

global remaining_minutes_in_oven
remaining_minutes_in_oven:
    mov rax, TIME
    sub rax, rdi
    ret

global preparation_time_in_minutes
preparation_time_in_minutes:
    mov rax, 2
    imul rax, rdi
    ret

global elapsed_time_in_minutes
elapsed_time_in_minutes:
    call preparation_time_in_minutes
    add rax, rsi
    ret
