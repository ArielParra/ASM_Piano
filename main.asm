.model small

.stack 100h

.data
include mac.inc

buff_input DB 10,?,10 DUP(?)
int16_aux DW 0
int8_var2 DB 0
str_string1 DB "hola mundo",'$';
str_string2 DB "preciona 1,2,3",'$';


jump_table DW case_1, case_2, case_3, case_default;


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
         XOR AH,AH
         SUB AX,30h;quitarle char 
         DEC AX;para empezar en 0
         
         
         ;validar rango
         CMP AX,3; pq solo son 3 de 0 a 2
         JL et_validado
         MOV AX,3;default
         
         et_validado:
         SHL AX,1
         LEA BX,jump_table
         ADD BX,AX;indice ya validado
         JMP [BX]
         
         case_1:
             putch 'A'
             beep note_A,1000
             JMP break
         
         case_2:
             putch 'F'
             beep note_F,1000
             JMP break
         
         case_3:
             putch 'C'
            beep note_C,1000
             JMP break
         
         case_default:
             putch 'd'
             JMP eliwh1;salir con def
         break:
         
        
    JMP while1   
    eliwh1:


        

exit
main ENDP


END;code segment