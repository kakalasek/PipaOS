mov bx, REAL_MSG
call print_string

jmp $

REAL_MSG db "Booting to 16 bit real mode"

; Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55