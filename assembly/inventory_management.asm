WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text
global get_box_weight
get_box_weight:
    xor eax, eax
    imul edi, esi
    imul edx, ecx
    add edi, edx
    add eax, edi
    add eax, WEIGHT_OF_EMPTY_BOX
    ret

global max_number_of_boxes
max_number_of_boxes:
    movzx ecx, dil
    mov eax, TRUCK_HEIGHT
    xor edx, edx
    div ecx
    ret

global items_to_be_moved
items_to_be_moved:
    sub edi, esi
    mov eax, edi
    ret

global calculate_payment
calculate_payment:
    mov   eax, esi
    imul  rax, rax, PAY_PER_BOX
    mov   edx, edx
    imul  rdx, rdx, PAY_PER_TRUCK_TRIP
    add   rax, rdx
    sub   rax, rdi
    mov   ecx, ecx
    imul  rcx, r8
    sub   rax, rcx
    movzx r9, r9b
    lea   rcx, [r9 + 1]
    cqo
    idiv  rcx
    add   rax, rdx
    ret
