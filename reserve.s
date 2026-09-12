.intel_syntax noprefix
.global solve
solve:
sub rsp, 256
mov rcx, 0

loop:
mov byte ptr [rsp+rcx], 0
cmp rcx, 255
je done
inc rcx
jmp loop

done:
add rsp, 256
ret
