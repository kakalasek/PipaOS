unsigned char port_byte_in(unsigned short port)
{
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data)
{
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

void int_to_ascii(int n, char str[])
{
    int i, sign;
    if ((sign = n) < 0) n = -n;
    i = 0;
    do {
        str[i++] = n % 10 + '0';
    } while ((n /= 10) > 0);

    if (sign < 0) str[i++] = '-';
    str[i] = '\0';
}