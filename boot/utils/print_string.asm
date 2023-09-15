[bits 16]
; Prints a null terminated string pointed to by BX
print_string:
    pusha
    mov ah, 0x0e    ; int 10/ah = 0eh -> scrolling teletype BIOS routine
    mov al, [bx]    ; Move the character pointed at by BX to AL

print_string_loop:
    int 0x10    ; Print character
    inc bx  ; Increment BX -> so BX is now pointing to the next character 
    mov al, [bx]    ; Move the character pointed at by BX to AL
    cmp al, 0   ; if (AL == 0), at the end of the string, so dont loop again
    jne print_string_loop

print_string_done:
    popa
    ret ; Return