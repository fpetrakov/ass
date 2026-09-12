.intel_syntax noprefix
.global solve
solve:
mov rdi, 1
lea rsi, [rsp+0x40]
mov rdx, 128
mov rax, 1
syscall

ret
