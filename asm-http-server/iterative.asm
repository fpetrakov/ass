%define sys_read 0
%define sys_write 1
%define sys_open 2
%define sys_close 3
%define sys_socket 41
%define sys_bind 49
%define sys_accept 43 
%define sys_listen 50
%define sys_exit 60
%define stdout 1
%define exit_success 0 
%define buf_size 4112

section .data
response db "HTTP/1.0 200 OK", 13, 10, 13, 10
response_len equ $ - response

section .text

mov rdi, 2 ; AF_INET
mov rsi, 1 ; SOCK_STREAM
mov rdx, 0
mov rax, sys_socket
syscall
mov r12, rax

sub rsp, buf_size
mov word [rsp], 2
mov word [rsp+2], 0x5000
mov dword [rsp+4], 0
mov qword [rsp+8], 0

mov rdi, rax
mov rsi, rsp
mov rdx, 16
mov rax, sys_bind
syscall

mov rdi, r12
mov rsi, 0
mov rax, sys_listen
syscall

.loop: 
    mov rdi, r12
    xor rsi, rsi
    xor rdx, rdx
    mov rax, sys_accept
    syscall

    mov r13, rax
    mov rdi, r13
    lea rsi, [rsp+16]
    mov rdx, 4096
    mov rax, sys_read
    syscall

    lea rsi, [rsp+16]
    xor rdi, rdi

    .find_method_end:
        cmp byte [rsi+rdi], ' '
        je .path_start
        inc rdi
        jmp .find_method_end

    .path_start:
        inc rdi
        mov rbx, rdi ; points at '/'

    .find_path_end:
        cmp byte [rsi+rdi], ' '
        je .path_end
        inc rdi
        jmp .find_path_end

    .path_end:
        mov byte [rsi+rdi], 0

    mov r8, rax
    lea rdi, [rsi+rbx] 
    xor rsi, rsi
    mov rax, sys_open
    syscall

    mov r14, rax
    mov rdi, r14
    lea rsi, [rsp+r8]
    mov rdx, 256
    mov rax, sys_read
    syscall

    mov rdi, r14
    mov r14, rax
    mov rax, sys_close
    syscall

    mov rdi, r13
    lea rsi, [rel response]
    mov rdx, response_len
    mov rax, sys_write
    syscall

    mov rdi, r13
    lea rsi, [rsp+r8]
    mov rdx, r14
    mov rax, sys_write
    syscall

    mov rdi, r13
    mov rax, sys_close
    syscall
jmp .loop

mov rdi, exit_success 
mov rax, sys_exit
syscall
