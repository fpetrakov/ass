.intel_syntax noprefix
.global str_upper
str_upper:
mov rsi, 0

loop: 
mov al, BYTE PTR [rdi]
cmp al, 0x0
je done
and al, 0xDF
mov [rdi], al
inc rdi
inc rsi
jmp loop

done:
ret
