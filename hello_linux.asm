; asm for Linux
;
; Author: Benzon Carlitos Salazar
;
; to build and executable:
;	$ nasm -f elf <filename>.asm	# build
;	$ ld -s -o hello -hello.o 	# this creates an executable


section .text
; export the entry point to the ELF linker or loader. The conventional 
; entry point is '_start'. Use 'ld -e foo' to override the default
	global _start

section .data
	msg db 'Hello, Linux!', 0xa	; our string
	len equ $ - msg			; length of our message

section .text

; linker puts the entry point here
_start:

; write the strings to stdout
	mov edx, len	; message length
	mov ecx, msg	; message to write
	mov ebc, 1	; file descriptor (stdout)
	mov eax, 4	; system call number (sys_write)
	int 0x80	; call kernel

; exit via the kernel
	mov ebx, 0	; process exit code
	mov eax, 1	; system call number (sys_exit)
	int 0x80	; call kernel - this interrupt won't return
