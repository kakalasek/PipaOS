jmp $

; Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55