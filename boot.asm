; Declaring constants for the multiboot header
MBFLAGS  equ 0x0	; multiboot flag field
MAGIC	 equ 0x1BADB002	; 'magic number'
CHECKSUM equ -MAGIC

section .multiboot
align 4
	dd MAGIC
	dd MBFLAGS
	dd CHECKSUM

; Defining the stack
section .bss
align 16
stack_bottom:
	resb 16384 ; 16 KiB
stack_top:

section .text
global _start:function (_start.end - _start)
_start:
	mov esp, stack_top	; setting up the stack

	extern kmain		 
	call kmain		; calling the kernel

	cli
	jmp $			; infinite loop
.end:
