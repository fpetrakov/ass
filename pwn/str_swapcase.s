.intel_syntax noprefix
.global str_swapcase
str_swapcase:
mov rsi, 0

loop:
mov al, BYTE PTR [rdi]
cmp al, 0x0
je done
xor BYTE PTR [rdi], 0x20
inc rsi
inc rdi
jmp loop


done:
ret
