
sleep MACRO int16_miliseconds
         MOV AX,int16_miliseconds
         MOV BX,10
         XOR DX,DX
         DIV BX
         porDiez;DX*10
         MOV CX,DX
         XOR DX,DX
         DIV BX
         ADD CX,DX        
         XOR DX,DX
         XCHG DX,CX 
         porDiez;
         porDiez;
         porDiez;DX*1000
         XCHG AX,CX 
         XOR   AL,AL
         MOV   AH, 86H
         INT   15H
ENDM
.model small

.stack 100h

.data
include mac.inc

buff_input DB 10,?,10 DUP(?)
int16_aux DW 0
int8_var2 DB 0
str_string1 DB "hola mundo",'$';
str_string2 DB "preciona a",'$';


; Define frequencies
C       equ 4560    ; Middle C
G       equ 6087    ; G
A       equ 5423    ; A
F       equ 6833    ; F
E       equ 7239    ; E
D       equ 8126    ; D

; Define durations
Medium  equ 20
Long    equ 30

.code
MOV AX,@DATA
MOV DS,AX

main PROC

   ;gets buff_input
   ;endl
   ;puts buff_input
   ;print str_string1
   ;endl
    
   while1:
        print str_string2
        endl
        
        kbhit 
        JZ while1
          
        getch
        CMP AL,'a' 
        JE eliwh1  
       
        
    JMP while1   
    eliwh1:
        ; Play "Twinkle, Twinkle, Little Star
        putch  'C'
        mov     ax, C
        mov     bx, Medium
        ;call    Beep
        
     
        sleep 555
        putch  'C'
        mov     ax, C
        mov     bx, Medium
        ;call    Beep
        sleep 255
            putch  'C'
        mov     ax, C
        mov     bx, Medium
        ;call    Beep
        

exit
main ENDP



Beep PROC 
    push   bx
    push   ax

    mov     al, 182         ; Prepare the speaker
    out     43h, al
    ;mov     ax, frequency   ; Load frequency number
    POP AX
    out     42h, al         ; Output low byte
    mov     al, ah          ; Output high byte
    out     42h, al

    in      al, 61h         ; Turn on note
    OR      al,00000011b   ; Set bits 1 and 0
    out     61h, al

    ;mov     cx, duration    ; Load duration
    POP CX
    mov int16_aux,CX
    sleep int16_aux      ; Loop until duration is zero

    in      al, 61h         ; Turn off note
    and     al, 11111100b   ; Reset bits 1 and 0
    out     61h, al
    ret                     ; Return from procedure
Beep ENDP


END;code segment