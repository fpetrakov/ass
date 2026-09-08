.intel_syntax noprefix
.global _start
_start:
mov rdi, [rsp+16]
cmp BYTE PTR [rdi], 'p'
jne fail
mov rdi, 0
mov rax, 60
syscall

fail:
mov rdi, 1
mov rax, 60
syscall
