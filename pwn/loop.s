.intel_syntax noprefix
.global _start
_start:
mov rdi, QWORD PTR [rsp+16]
mov rsi, 0

loop:
mov al, BYTE PTR [rdi]
cmp al, 0x0
je success
inc rdi
inc rsi
jmp loop

success:
mov rdi, rsi
mov rax, 60
syscall
