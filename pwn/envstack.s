.intel_syntax noprefix
.global _start
_start:
mov rdi, 1
mov rsi, [rsp+24]
mov rdx, 128
mov rax, 1
syscall

mov rdi, 0
mov rax, 60
syscall
