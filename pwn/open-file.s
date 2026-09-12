.intel_syntax noprefix
.global _start
_start:
mov rdi, [rsp+16]
mov rsi, 0
mov rax, 2
syscall

mov rdi, rax
mov rsi, rsp
mov rdx, 128
mov rax, 0
syscall

mov rdi, 1
mov rsi, rsp
mov rdx, rax
mov rax, 1
syscall

mov rdi, 42
mov rax, 60
syscall
