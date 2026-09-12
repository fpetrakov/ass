.intel_syntax noprefix
.global solve
solve:
	call rdi
	mov rdi, 1
	lea rsi, [rsp-0x88]
	mov rdx, 128
	mov rax, 1
	syscall
	ret
