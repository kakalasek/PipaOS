[org 0x7c00]

mov bx, REAL_MSG
call print_string

jmp $

%include 'utils/print_string.asm'

REAL_MSG db 'Booting to 16 bit real mode', 0

; Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55