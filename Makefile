# GCC compiler options
CFLAGS ?= -m32 -ffreestanding -fno-pie -mgeneral-regs-only

# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# Convert *.c to *.o to give a list of object files to build
OBJ = ${C_SOURCES:.c=.o}

# Default build target
all: os-image

# Run qemu to simulate booting of our code
run: all
	qemu-system-i386 os-image

# This is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
os-image: boot/boot-sector.bin kernel/kernel.bin
	cat $^ > os-image

# This builds the binary of our kernel from two object files:
# - the kernel_entry, which jumps to main() in our kernel
# - the compiled C kernel
kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# Generic rule for compiling C code to an object file
# For simplicity, we kame C files depend on all header files
%.o: %.c ${HEADERS}
	gcc $(CFLAGS) -c $< -o $@

# Assembles the kernel_entry
kernel/kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf -o $@

# Assembles the bootsector
boot/boot-sector.bin: boot/boot-sector.asm
	nasm $< -f bin -I 'boot/' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image
	rm -rf kernel/*.o boot/*.bin drivers/*.o kernel/*.bin