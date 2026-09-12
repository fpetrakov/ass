.intel_syntax noprefix
.global solve
solve:
    sub rsp, 256
    xor rcx, rcx
clear_loop:
    mov byte ptr [rsp+rcx], 0
    inc rcx
    cmp rcx, 256
    jl clear_loop
    xor rcx, rcx
scan_loop:
    cmp rcx, rsi
    jge scan_done
    movzx rax, byte ptr [rdi+rcx]   
    mov byte ptr [rsp+rax], 1       
    inc rcx
    jmp scan_loop
scan_done:
    xor rax, rax
    xor rcx, rcx
count_loop:
    cmp rcx, 256
    jge count_done
    movzx rdx, byte ptr [rsp+rcx]
    add rax, rdx
    inc rcx
    jmp count_loop
count_done:
    add rsp, 256
    ret
