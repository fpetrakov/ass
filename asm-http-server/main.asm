%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_CLOSE 3
%define SYS_SOCKET 41
%define SYS_BIND 49
%define SYS_ACCEPT 43 
%define SYS_LISTEN 50
%define SYS_EXIT 60
%define STDOUT 1
%define EXIT_SUCCESS 0 
%define BUF_SIZE 4112

section .data
response db "HTTP/1.0 200 OK", 13, 10, 13, 10
response_len equ $ - response

section .text

mov rdi, 2 ; AF_INET
mov rsi, 1 ; SOCK_STREAM
mov rdx, 0
mov rax, SYS_SOCKET
syscall
mov r12, rax

sub rsp, BUF_SIZE
mov word [rsp], 2
mov word [rsp+2], 0x5000
mov dword [rsp+4], 0
mov qword [rsp+8], 0

mov rdi, rax
mov rsi, rsp
mov rdx, 16
mov rax, SYS_BIND
syscall

mov rdi, r12
mov rsi, 0
mov rax, SYS_LISTEN
syscall

mov rdi, r12
xor rsi, rsi
xor rdx, rdx
mov rax, SYS_ACCEPT
syscall
mov r12, rax

mov rdi, r12
lea rsi, [rsp+16]
mov rdx, 4096
mov rax, SYS_READ
syscall

mov rdi, r12
lea rsi, [rel response]
mov rdx, response_len
mov rax, SYS_WRITE
syscall

mov rdi, r12
mov rax, SYS_CLOSE
syscall

mov rdi, EXIT_SUCCESS 
mov rax, SYS_EXIT
syscall
