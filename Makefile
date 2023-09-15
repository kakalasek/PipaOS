# Default build target
all: os-image

# Run qemu to simulate booting of our code
run: all
	qemu-system-i386 os-image

# This is the actual disk image that the computer loads
os-image: boot/boot-sector.bin
	cat $^ > os-image

# Assembles the bootsector
boot/boot-sector.bin: boot/boot-sector.asm
	nasm $< -f bin -I 'boot/' -o $@