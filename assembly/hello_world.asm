section .data
    msg db "Hello, World!", 10
    len equ $ - msg

section .text
    default rel
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, [msg]
    mov rdx, len
    syscall

    xor rdi, rdi
    mov rax, 60
    syscall
