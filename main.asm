.model small

.stack 100h

.data
include mac.inc

buff_input DB 10,?,10 DUP(?)
int16_aux DW 0
int8_var2 DB 0
str_string1 DB "hola mundo",'$';
str_string2 DB "preciona a",'$';


; constants notes
note_C       equ 4560    ; Middle C
note_G       equ 6087    ; G
note_A       equ 5423    ; A
note_F       equ 6833    ; F
note_E       equ 7239    ; E
note_D       equ 8126    ; D


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
        beep note_C, 1000

        sleep 1000
        putch  'C'

        beep note_C, 1000
        sleep 255

        putch  'C'
        beep note_C, 1000

        

exit
main ENDP


END;code segment