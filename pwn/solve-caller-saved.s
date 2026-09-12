.intel_syntax noprefix
.global solve
solve:
push rax
push rcx
push rdx
push r8
push r9
push r10
push r11
push rsi

call rdi

pop rsi
pop r11
pop r10
pop r9
pop r8
pop rdx
pop rcx
pop rax

call rsi

mov rdi, 0
mov rax, 60
syscall
