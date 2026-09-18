%define ROUND_UP 2
%define ROUND_DOWN 1

section .data
    hours dq 8.0
    hundred dq 100.0
    percent dq 0.01
    hours_month dq 176.0

section .text
default rel

global daily_rate
daily_rate:
    mulsd xmm0, [rel hours]
    ret

global apply_discount
apply_discount:
    movsd xmm2, [rel hundred]
    subsd xmm2, xmm1
    mulsd xmm0, xmm2
    mulsd xmm0, [rel percent]
    ret

global monthly_rate
monthly_rate:
    mulsd xmm0, [rel hours_month]
    call apply_discount
    roundsd xmm0, xmm0, ROUND_UP
    cvtsd2si rax, xmm0
    ret

global days_in_budget
days_in_budget:
    cvtsi2sd xmm3, rdi
    call apply_discount
    call daily_rate
    divsd xmm3, xmm0
    roundsd xmm3, xmm3, ROUND_DOWN
    cvtsd2si eax, xmm3
    ret
