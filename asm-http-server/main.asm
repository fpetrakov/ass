section .data
response db "HTTP/1.0 200 OK", 13, 10, 13, 10
response_len equ $ - response

section .text

mov rdi, 2 ; AF_INET
mov rsi, 1 ; SOCK_STREAM
mov rdx, 0
mov rax, 41
syscall
mov r12, rax

sub rsp, 4112
mov word [rsp], 2
mov word [rsp+2], 0x5000
mov dword [rsp+4], 0
mov qword [rsp+8], 0

mov rdi, rax
mov rsi, rsp
mov rdx, 16
mov rax, 49
syscall

mov rdi, r12
mov rsi, 0
mov rax, 50
syscall

mov rdi, r12
xor rsi, rsi
xor rdx, rdx
mov rax, 43
syscall
mov r12, rax

mov rdi, r12
lea rsi, [rsp+16]
mov rdx, 4096
mov rax, 0
syscall

mov rdi, r12
lea rsi, [rel response]
mov rdx, response_len
mov rax, 1
syscall

mov rdi, r12
mov rax, 3
syscall

mov rdi, 0
mov rax, 60
syscall
