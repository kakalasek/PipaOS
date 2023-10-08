#include "../drivers/vga.h"
#include "../drivers/idt.h"
#include "../drivers/pic.h"
#include "../drivers/keyboard.h"

void main()
{
    init_idt_32();
    PIC_remap(PIC1, PIC2);
    unsigned char a = keyboard_read_scan_code();
    if(a < 20) print_string("LESS");
    else print_string("MORE");
}