.intel_syntax noprefix
.global _start
_start:
mov rdi, 1
mov rsi, [rsp+16]
mov rdx, 10
mov rax, 1
syscall
mov rax, 60
syscall
