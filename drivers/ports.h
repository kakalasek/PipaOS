#ifndef _KERNEL_PORTS_H
#define _KERNEL_PORTS_H

unsigned char port_byte_in(unsigned short port);
void port_byte_out(unsigned short port, unsigned char data);

#endif