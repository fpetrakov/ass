.intel_syntax noprefix
.global _start
_start:
mov rdi, [rsp+16]

push rdi
call atoi
pop rdi

mov rdi, rax
mov rax, 60
syscall
