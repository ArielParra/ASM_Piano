.model small

.stack 100h

.data
include mac.inc

;variables
buff_input DB 10,?,10 DUP(?)
int16_aux DW 0
int8_var2 DB 0
str_string1 DB "presiona numeros y letras para sonido y esc para salir",'$';
int16_sostenido DW 800 ;ms
;constantes

jumpTable_numbers DW c_0,c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,case_default;
jumpTable_letters DW a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,default

;notas
note_C       equ 9121    ; C   - 130.81 Hz
note_Csharp  equ 8609    ; C#  - 138.59 Hz
note_D       equ 8126    ; D   - 146.83 Hz
note_Dsharp  equ 7670    ; D#  - 155.56 Hz
note_E       equ 7239    ; E   - 164.81 Hz
note_F       equ 6833    ; F   - 174.61 Hz
note_Fsharp  equ 6449    ; F#  - 185.00 Hz
note_G       equ 6087    ; G   - 196.00 Hz
note_Gsharp  equ 5746    ; G#  - 207.65 Hz
note_A       equ 5423    ; A   - 220.00 Hz
note_Asharp  equ 5119    ; A#  - 233.08 Hz
note_B       equ 4831    ; B   - 246.94 Hz
note_middleC equ 4560    ; C   - 261.63 Hz
note_Csharp2 equ 4304    ; C#  - 277.18 Hz
note_D2      equ 4063    ; D   - 293.66 Hz
note_Dsharp2 equ 3834    ; D#  - 311.13 Hz
note_E2      equ 3619    ; E   - 329.63 Hz
note_F2      equ 3416    ; F   - 349.23 Hz
note_Fsharp2 equ 3224    ; F#  - 369.99 Hz
note_G2      equ 3043    ; G   - 391.00 Hz
note_Gsharp2 equ 2873    ; G#  - 415.30 Hz
note_A2      equ 2711    ; A   - 440.00 Hz
note_Asharp2 equ 2559    ; A#  - 466.16 Hz
note_B2      equ 2415    ; B   - 493.88 Hz
note_C2      equ 2280    ; C   - 523.25 Hz
note_Csharp3 equ 2152    ; C#  - 554.37 Hz
note_D3      equ 2031    ; D   - 587.33 Hz
note_Dsharp3 equ 1917    ; D#  - 622.25 Hz
note_E3      equ 1809    ; E   - 659.26 Hz
note_F3      equ 1715    ; F   - 698.46 Hz
note_Fsharp3 equ 1612    ; F#  - 739.99 Hz
note_G3      equ 1521    ; G   - 783.99 Hz
note_Gsharp3 equ 1436    ; G#  - 830.61 Hz
note_A3      equ 1355    ; A   - 880.00 Hz
note_Asharp3 equ 1292    ; A#  - 923.33 Hz
note_B3      equ 1207    ; B   - 987.77 Hz
note_C3      equ 1140    ; C   - 1046.50 Hz


.code
MOV AX,@DATA
MOV DS,AX

main PROC

   ;gets buff_input
   ;endl
   ;puts buff_input
   ;print str_string1
   ;endl
   print str_string1
   endl

   while1:
        
        kbhit 
        JZ while1
          
         getch
         XOR AH, AH

         CMP AL,1Bh;'esc' 
         JNE et_continue
         exit

         et_continue:

         CMP AL, '9'
         JG et_validarLetras

         et_validarNumeros:
               SUB AL, '0'
               CMP AX,10
               JL et_numerosValidados
               MOV AX,10;default

               et_numerosValidados:
                  SHL AX,1
                  LEA BX,jumpTable_numbers
                  ADD BX,AX;indice ya validado
                  JMP [BX]
               
         et_validarLetras:
               SUB AL, 'a'         
               ;validar rango
               CMP AX,26; 'z' - 'a'
               JL et_letrasValidadas
               MOV AX,26;default
         
              et_letrasValidadas:
                  SHL AX,1
                  LEA BX,jumpTable_Letters
                  ADD BX,AX
                  JMP [BX]
         
         switch_numbers:
               c_1:
                   putch 'C'
                   beep note_C,int16_sostenido
                   JMP break
               
               c_2:
                   putch 'D'
                   beep note_D, int16_sostenido
                   JMP break
               
               c_3:
                   putch 'E'
                   beep note_E, int16_sostenido
                   JMP break
               
               c_4:
                   putch 'F'
                   beep note_F, int16_sostenido
                   JMP break
               
               c_5:
                   putch 'G'
                   beep note_G, int16_sostenido
                   JMP break
               
               c_6:
                   putch 'A'
                   beep note_A, int16_sostenido
                   JMP break
               
               c_7:
                  putch 'B'
                   beep note_B, int16_sostenido
                   JMP break
               
               c_8:
                   putch 'C'
                   putch '2'
                   beep note_C2, int16_sostenido
                   JMP break
               
               c_9:
                   putch 'D'
                   putch '2'
                   beep note_D2, int16_sostenido
                   JMP break
               
               c_0:
                   putch 'E'
                   putch '2'
                   beep note_E2, int16_sostenido
                   JMP break
               case_default:
                     putch '.'
               JMP break 

         switch_letters:
               q:
                   putch 'F'
                   putch '2'
                   beep note_F2,int16_sostenido
                   JMP break
               
               w:
                   putch 'G'
                   putch '2'
                   beep note_G2, int16_sostenido
                   JMP break
               
               e:
                   putch 'A'
                   putch '2'
                   beep note_A2, int16_sostenido
                   JMP break
               
               r:
                   putch 'B'
                   putch '2'
                   beep note_B2, int16_sostenido
                   JMP break
               
               t:
                   putch 'C'
                   putch '3'  
                   beep note_C3, int16_sostenido
                   JMP break
               
               y:
                   putch 'D'
                   putch '3'  
                   beep note_D3, int16_sostenido
                   JMP break
               
               u:
                   putch 'E'
                   putch '3'  
                   beep note_E3, int16_sostenido
                   JMP break
               
               i:
                   putch 'F'
                   putch '3'
                   beep note_F3, int16_sostenido
                   JMP break
               
               o:
                   putch 'G'
                   putch '3'
                   beep note_G3, int16_sostenido
                   JMP break
               
               p:
                   putch 'A'
                   putch '3'
                   beep note_A3, int16_sostenido
                   JMP break
               
               a:
                   putch 'B'
                   putch '3'
                   beep note_B3, int16_sostenido
                   JMP break
               
               s:
                   putch 'C'
                   putch '#'
                   beep note_Csharp, int16_sostenido
                   JMP break
               
               d:
                   putch 'D'
                   putch '#'
                   beep note_Dsharp, int16_sostenido
                   JMP break
               
               f:
                   putch 'E'
                   putch '2'
                   beep note_E2, int16_sostenido
                   JMP break
               
               g:
                   putch 'F'
                   putch '#'
                   beep note_Fsharp, int16_sostenido
                   JMP break
               
               h:
                   putch 'G'
                   putch '#'
                   beep note_Gsharp, int16_sostenido
                   JMP break
               j:
                   putch 'A'
                   putch '#'
                   beep note_Asharp, int16_sostenido
                   JMP break
               
               k:
                   putch 'B'
                   putch '2'
                   beep note_B2, int16_sostenido
                   JMP break
               
               l:
                   putch 'C'
                   putch '#'
                   putch '2'
                   beep note_Csharp2, int16_sostenido
                   JMP break
               
               z:
                   putch 'D'
                   putch '#'
                   putch '2'
                   beep note_Dsharp2, int16_sostenido
                   JMP break
               
               x:
                   putch 'E'
                   putch '3'
                   beep note_E3, int16_sostenido
                   JMP break
               
               c:
                   putch 'F'
                   putch '#'
                   putch '2'
                   beep note_Fsharp2, int16_sostenido
                   JMP break
               
               v:
                   putch 'G'
                   putch '#'
                   putch '2'
                   beep note_Gsharp2, int16_sostenido
                   JMP break
               
               b:
                   putch 'A'
                   putch '#'
                   putch '2'
                   beep note_Asharp2, int16_sostenido
                   JMP break
               
               n:
                   putch 'B'
                   putch '3'
                   beep note_B3, int16_sostenido
                   JMP break
               m:
                   putch 'C'
                   putch '#'
                   putch '3'
                   beep note_Csharp3, int16_sostenido
                   JMP break
               
               default:
                   putch '.'

         break:
         putch ' ';
         
         
        
    JMP while1   
    eliwh1:


        

exit
main ENDP


END;code segment