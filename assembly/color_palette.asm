section .data
global base_color
base_color dd 0xFFFFFF00

global RED
RED dd 0xFF000000

global GREEN
GREEN dd 0x00FF0000

global BLUE
BLUE dd 0x0000FF00

extern combining_function

section .text
default rel

global get_color_value
get_color_value:
	mov eax, dword [rdi]
    ret

global add_base_color
add_base_color:
    mov eax, dword [rdi]
	mov dword [base_color], eax
    ret

global make_color_combination
make_color_combination:
	push rdi
    mov edi, dword [base_color]
    mov esi, dword [rsi]
	call combining_function
	pop rdi
	mov dword [rdi], eax
    ret
