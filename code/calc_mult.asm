; Calculator Multiply
;
; Author: Prof. Carlos M. De La Torre-Ugarte
; email : cdelatorre@pupr.edu
; Date  : 04/03/2018
;
; Compile with: nasm -f elf calc_mult.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 calc_mult.o -o calc_mult
; Run with: ./calc_mult 20 1000 317

%include 'functions.asm'

SECTION .text
    global  _start

_start:
    pop     ecx             ; first value on the stack is the number of arguments
    pop     eax             ; remove first value (program name) on the stack
    dec     ecx             ; decrease ecx to eliminate first argument
    mov     edx, 1          ; initialise edx to one
    cmp     ecx, 0h         ; check to see if any arguments
    jz      noArgs          ; if not print usage message

nextArg:
    cmp     ecx, 0h         ; check to see if we have any arguments left
    jz      noMoreArgs      ; if zero flag is set jump to noMoreArgs label (jumping over the end of the loop)
    pop     eax             ; pop the next argument off the stack
    call    atoi            ; convert our ascii string to decimal integer
    mul     edx             ; perform our addition logic
    mov     edx, eax        ; save result in edx to continue multiplying
    dec     ecx             ; decrease ecx (number of arguments left) by 1
    jmp     nextArg         ; jump to nextArg label

noMoreArgs:
    mov     eax, edx        ; move our data result into eax for printing
    call    iprintLF        ; call our integer printing with linefeed function
    jmp     exit

noArgs:
    mov     eax, usage
    call    sprint

exit:
    call    quit            ; call our quit function

SECTION .data
    usage db 'USAGE: ./calc_mult [number1] [number2] [number3] ...', 10
