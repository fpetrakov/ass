WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

global get_box_weight
get_box_weight:
    push rdx
    mov rax, rdi
    mul rsi
    mov r8, rax

    pop rax
    mul rcx
    add r8, rax    

    add r8, WEIGHT_OF_EMPTY_BOX 
    mov rax, r8
    ret

global max_number_of_boxes
max_number_of_boxes:
    movzx rcx, dil
    mov rax, TRUCK_HEIGHT
    xor rdx, rdx
    div rcx
    ret

global items_to_be_moved
items_to_be_moved:
    movzx rax, edi
    sub eax, esi
    ret

global calculate_payment
calculate_payment:
    mov r10d, esi
    imul r10, r10, PAY_PER_BOX
    
    mov r11d, edx
    imul r11, r11, PAY_PER_TRUCK_TRIP

    add, r10, r11

    mov eax, ecx
    imul rax, r8

    sub r10, rdi
    sub r10, rax

    movzx rcx, r9b
    inc rcx

    mov rax, r10
    cqo
    idiv rcx

    add rax, rdx
    ret
