.intel_syntax noprefix
.global _start
_start:
	push 0x1
	push 0x2
	push 0x3

	pop rax
	pop rbx
	pop rcx
	
	mov rdi, 0
	mov rax, 60	
	syscall
