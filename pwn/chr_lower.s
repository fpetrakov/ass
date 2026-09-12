.intel_syntax noprefix
.global chr_lower
chr_lower:
mov rax, 0x20
or rax, rdi
ret
