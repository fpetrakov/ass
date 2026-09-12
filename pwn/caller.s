.intel_syntax noprefix
.global solve
solve:
mov rax, rdi
mov rdi, 1337
call rax
mov rdi, 0
mov rax, 60
syscall
