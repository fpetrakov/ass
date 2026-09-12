.intel_syntax noprefix
mov rax, 0xB5
mov rbx, [rax]
mov rax, 0xA5
mov [rax], ebx

mov rax, 0
mov rbx, [rsp+rax*8]
inc rax
mov rcx, [rsp+rax*8]

mov rax, 1
pop rcx
lea rbx, [rsp+rax*8]
mov rbx, [rbx]
