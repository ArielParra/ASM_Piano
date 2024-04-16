;
;https://github.com/zserge/beep
.model small

.stack 100h

.data
include mac.inc

buff_input DB 10,?,10 DUP(?)
int16_var1 DW 0
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

.stack 100h


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
  
        ; Play "Twinkle, Twinkle, Little Star"
        putch  'C'
        call    PlayC
        CALL DelayBetweenNotes
        putch  'C'
        call    PlayC
        putch 'G'
        call    PlayG
                CALL DelayBetweenNotes
        putch 'G'
        call    PlayG
        putch 'A'
        call    PlayA
                CALL DelayBetweenNotes

        putch 'A'
        call    PlayA
        putch 'G'
        call    PlayG
        putch 'F'
        call    PlayF
                CALL DelayBetweenNotes

        putch 'F'
        call    PlayF
        putch 'E'
        call    PlayE
                CALL DelayBetweenNotes

        putch 'E'
        call    PlayE
        putch 'D'
        call    PlayD
                CALL DelayBetweenNotes

        putch 'D'
        call    PlayD
        putch  'C'
        call    PlayC
 
 

    
exit
main ENDP

    ; Procedures to play each note
    PlayC proc
        mov     ax, C
        mov     bx, Medium
        call    Beep
        ret
    PlayC endp

    PlayG proc
        mov     ax, G
        mov     bx, Medium
        call    Beep
        ret
    PlayG endp

    PlayA proc
        mov     ax, A
        mov     bx, Medium
        call    Beep
        ret
    PlayA endp

    PlayF proc
        mov     ax, F
        mov     bx, Medium
        call    Beep
        ret
    PlayF endp

    PlayE proc
        mov     ax, E
        mov     bx, Medium
        call    Beep
        ret
    PlayE endp

    PlayD proc
        mov     ax, D
        mov     bx, Medium
        call    Beep
        ret
    PlayD endp

DelayBetweenNotes PROC
    mov     cx, 65535         ; Adjust this value to control the delay
.delay_loop:
    dec     cx
    jnz     .delay_loop
    ret
DelayBetweenNotes ENDP



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
    or      al, 00000011b   ; Set bits 1 and 0
    out     61h, al

    ;mov     cx, duration    ; Load duration
    POP CX
.delay:
    mov     dx, 65535       ; Set up inner loop counter
.inner_delay:
    dec     dx              ; Decrement inner loop counter
    jne     .inner_delay    ; Loop until zero
    loop    .delay          ; Loop until duration is zero

    in      al, 61h         ; Turn off note
    and     al, 11111100b   ; Reset bits 1 and 0
    out     61h, al
    ret                     ; Return from procedure
Beep ENDP


END;code segment

;https://www.cs.binghamton.edu/~reckert/220/8254_timer.html
;https://web.archive.org/web/20160712192529/http://muruganad.com/8086/8086-assem