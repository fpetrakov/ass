.intel_syntax noprefix
.global LOBYTE
LOBYTE:
mov rax, 0xFF
and rax, rdi
ret
