.intel_syntax noprefix
.global _start
_start:
mov rdi, 0
mov rsi, rsp
mov rdx, 128
mov rax, 0
syscall

mov rdi, 1
mov rsi, rsp
mov rdx, 128
mov rax, 1
syscall

mov rdi, 42
mov rax, 60
syscall
