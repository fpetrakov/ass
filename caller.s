.intel_syntax noprefix
.global _start
_start:
push 0x41414141
mov rdi, rsp
mov rsi, 4
call solve
