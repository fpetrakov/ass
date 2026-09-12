.intel_syntax noprefix
.global solve
solve:
mov rax, 0x01
and rax, rdi
xor rax, 0x01
ret
