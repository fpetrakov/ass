C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

TRUE equ 1
FALSE equ 0

section .text

global value_of_card
value_of_card:
    cmp dil, 14
    je .ca

    cmp dil, 11
    jb .bot

    jmp .top

    .ca:
        mov al, 1
        ret
    
    .top:
        mov al, 10
        ret

    .bot:
        mov al, dil
        ret 

global higher_card
higher_card:
    mov r12, rdi        
    mov r13, rsi        

    mov rdi, r12
    call value_of_card
    mov rbx, rax        

    mov rdi, r13
    call value_of_card  

    xor rdx, rdx
    cmp rbx, rax
    je .equal
    jg .card_one_higher

    mov rax, r13
    jmp .done

    .card_one_higher:
        mov rax, r12
        jmp .done

    .equal:
        mov rax, r12        
        mov rdx, r13
        jmp .done

    .done:
        ret

global value_of_ace
value_of_ace:
    add rdi, rsi
    add rdi, 11
    
    cmp rdi, 21
    ja .one

    mov rax, 11
    ret

    .one:
        mov rax, 1
        ret

global is_blackjack
is_blackjack:
    mov r12, rdi        
    mov r13, rsi        

    call value_of_card
    mov rbx, rax        

    mov rdi, r13
    call value_of_card  

    cmp rbx, 1
    jne .check_case2
    cmp rax, 10
    je .true

    .check_case2:
    cmp rbx, 10
    jne .false
    cmp rax, 1
    je .true

    .false:
        mov rax, FALSE
        ret

    .true:
        mov rax, TRUE
        ret

global can_split_pairs
can_split_pairs:
    push rsi
    call value_of_card
    pop rsi
    mov rbx, rax
    mov rdi, rsi
    call value_of_card
    cmp rax, rbx 
    je .true 
    jmp .false

    .true:
        mov rax, TRUE
        ret

    .false:
        mov rax, FALSE
        ret

global can_double_down
can_double_down:
    push rsi
    call value_of_card 
    pop rsi
    mov rbx, rax
    mov rdi, rsi
    call value_of_card
    add rax, rbx 
    cmp rax, 9
    jge .check
    jmp .false

    .check:
        cmp rax, 11
        jle .true

    .false:
        mov rax, FALSE
        ret

    .true:
        mov rax, TRUE
        ret
