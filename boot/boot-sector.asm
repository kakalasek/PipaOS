;
; BOOT SECTOR
;
[org 0x7c00] ; Tells the assembler where this code will be loaded

mov bp, 0x9000 ; Set-up the stack
mov sp, bp

mov bx, REAL_MSG
call print_string

jmp $ ; Hang

; Includes
%include 'utils/print_string.asm'

; Global variables
REAL_MSG db 'Booting to 16 bit real mode', 0

; Padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55