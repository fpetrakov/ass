section .data
    last_counts db 0, 2, 5, 3, 7, 8, 4, 0
    current_counts db 0, 0, 0, 0, 0, 0, 0, 0

section .bss
    current_week_days resb 1   

section .text
default rel

global last_week_counts
last_week_counts:
    mov rax, qword [rel last_counts]
    ret

global current_week_counts
current_week_counts:
    mov rax, [rel current_counts]
    movzx rdx, byte [rel current_week_days]
    ret


global save_count
save_count:
    movzx rsi, byte [rel current_week_days]
    cmp rsi, 7
    jne .insert

    mov rax, qword [rel current_counts]
    mov qword [rel last_counts], rax
    mov qword [rel current_counts], 0
    mov byte [rel current_week_days], 0
    xor rsi, rsi

    .insert:
        lea rax, [rel current_counts]
        mov [rax+rsi], dil
        inc byte [rel current_week_days]
        ret

global today_count
today_count:
    movzx rcx, byte [rel current_week_days]
    dec rcx
    lea rax, [rel current_counts]
    movzx rax, byte [rax+rcx]
    ret

global update_today_count
update_today_count:
    movzx rcx, byte [rel current_week_days]
    dec rcx
    lea rax, [rel current_counts]
    add byte [rax+rcx], dil
    ret

global update_week_counts
update_week_counts:
    mov rax, qword [rel current_counts]
    mov qword [rel last_counts], rax
    mov qword [rel current_counts], rdi
    ret
