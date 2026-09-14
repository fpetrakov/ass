.intel_syntax noprefix
.global atoi_digit
.global atoi
.text

atoi_digit:
    movzx eax, byte ptr [rdi]
    sub eax, 0x30
    ret

atoi:
    push rbx
    mov rbx, rdi
    xor r11, r11
    push r11

.loop:
    movzx eax, byte ptr [rbx]
    test al, al
    jz .done

    push rbx
    mov rdi, rbx
    call atoi_digit
    pop rbx

    pop r11
    imul r11, 10
    add r11, rax
    push r11

    inc rbx
    jmp .loop

.done:
    pop rax
    pop rbx
    ret
