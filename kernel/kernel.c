#include "../drivers/vga.h"
#include "../drivers/idt.h"

void main()
{
    init_idt_32();
}