section .data
    hours dq 8.0

section .text
default rel

global daily_rate
daily_rate:
    mulsd xmm0, [rel hours]
    ret

global apply_discount
apply_discount:
    ret

global monthly_rate
monthly_rate:
    ret

global days_in_budget
days_in_budget:
    ret
