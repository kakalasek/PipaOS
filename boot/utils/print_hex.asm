; prints the value of DX as hex
print_hex:
    pusha
    mov cx, 4   ; Start the counter: we want to print 4 characters
                ; 4 bits per char, so we're printing a total of 16 bits

print_hex_loop:
    dec cx  ; Decrement the counter

    mov ax, dx  ; Copy BX into AX so we can mask it for the last chars
    shr dx, 4   ; Shift BX by 4 bits to the right
    and ax, 0xf ; Mask AH to get the last 4 bits

    mov bx, HEX_OUT ; Set BX to the memory address of our string
    add bx, 2       ; Skip the '0x'
    add bx, cx      ; Add the current counter to the address

    cmp ax, 0xa     ; Check to see if it's a letter or number
    jl set_letter   ; If it's a number, go straight to setting the value
    add byte [bx], 7; If it's a letter, add 7
                    ; Why this magic number? ASCII letters start 17
                    ; characters after decimal numbers. We need to cover
                    ; that distance. If our value is a 'letter' it's already
                    ; over 10, so we need to add 7 more
    jl set_letter

set_letter:
    add byte [bx], al   ; Add the value of the byte to the char at BX

    cmp cx, 0           ; Check the counter, compare with 0
    je print_hex_done   ; if the counter is 0, finish
    jmp print_hex_loop  ; otherwise, loop again

print_hex_done:    
    mov bx, HEX_OUT     ; print the string pointed to
    call print_string   ; by BX

    popa
    ret

; Variables
HEX_OUT db '0x0000', 0