CC = /home/kali/opt/cross/bin/i686-elf-gcc
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LD = ${CC}
LDFLAGS = -T linker.ld -ffreestanding -O2 -nostdlib -lgcc
AS = nasm
ASFLAGS = -felf32
VM = qemu-system-i386
VMFLAGS = -kernel

ALL: os.bin

run: os.bin
	${VM} ${VMFLAGS} os.bin

%.o: %.c
	${CC} -c kmain.c -o kmain.o ${CFLAGS}

%.o: %.asm
	${AS} ${ASFLAGS} boot.asm -o boot.o

os.bin: boot.o kmain.o
	${LD} ${LDFLAGS} boot.o kmain.o -o os.bin

clean:
	rm -rf *.o os.bin
