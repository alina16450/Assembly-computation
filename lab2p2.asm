bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 19
    b db 14
    c dw -7
    x dq -3

; our code starts here
segment code use32 class=code
    start:
        ;(a+b/c-1)/(b+2)-x
        movsx ax, [b]
        cwd                 ;dx:ax = b
        idiv word[c]        ;ax = b/c
        cwde                ;ax->eax
        mov ebx, [a] 
        add ebx, eax        ;ebx = a+b/c
        sub ebx, 1          ;eax = a+b/c-1
        mov al, [b]         ;AL = b
        add al, 2           ;AL = b + 2
        movsx bx, al        
        mov eax, ebx        
        cdq                 ;eax->edx:eax
        idiv bx             ;eax = (a+b/c-1)/(b+2)
        mov ebx, [x]
        mov ecx, [x+4]
        clc
        sub eax, ebx
        sbb edx, ecx
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
