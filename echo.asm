; echo.asm - simple echo: read from stdin, write back to stdout
; NASM, x86_64 Linux

section .bss
buffer: resb 1024

section .text
global _start

_start:
    ; read up to 1024 bytes from stdin (fd=0)
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    lea rsi, [rel buffer]
    mov rdx, 1024
    syscall

    ; rax = bytes read
    cmp rax, 0
    jle done

    ; write those bytes to stdout (fd=1)
    mov rdx, rax
    mov rax, 1          ; sys_write
    mov rdi, 1
    lea rsi, [rel buffer]
    syscall

done:
    mov rax, 60         ; sys_exit
    xor rdi, rdi
    syscall
