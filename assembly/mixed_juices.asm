section .data
    drink_to_time db 0, 1, 3, 3, 4, 5, 4, 7, 10

section .text
default rel

global time_to_make_juice
time_to_make_juice:
    lea rax, [rel drink_to_time]
    movzx rax, byte [rax + rdi]
    ret

global time_to_prepare
time_to_prepare:
    xor eax, eax
    xor edx, edx
    mov rcx, rdi

    .loop:
        cmp edx, esi
        je .done
        mov r8d, eax
        mov edi, dword [rcx + rdx*4]
        call time_to_make_juice
        add eax, r8d
        inc edx
        jmp .loop

    .done:
        ret

global limes_to_cut
limes_to_cut:

global remaining_orders
remaining_orders:
