.model small

.stack 100h

.data
include mac.inc
include song.inc


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
note_C3       equ 9121; Do 
note_Csharp3  equ 8609; Do sostenido
note_D3       equ 8126; Re
note_Dsharp3  equ 7670; Re sostenido
note_E3       equ 7239; Mi
note_F3       equ 6833; Fa
note_Fsharp3  equ 6449; Fa sostenido
note_G3       equ 6087; Sol
note_Gsharp3  equ 5746; Sol sostenido
note_A3       equ 5423; La
note_Asharp3  equ 5119; La sostenido
note_B3       equ 4831; Si
note_C4       equ 4560; Do
note_Csharp4  equ 4304; Do sostenido
note_D4       equ 4063; Re
note_Dsharp4  equ 3834; Re sostenido
note_E4       equ 3619; Mi
note_F4       equ 3416; Fa
note_Fsharp4  equ 3224; Fa sostenido
note_G4       equ 3043; Sol
note_Gsharp4  equ 2873; Sol sostenido
note_A4       equ 2711; La
note_Asharp4  equ 2559; La sostenido
note_B4       equ 2415; Si
note_C5       equ 2280; Do
note_Csharp5  equ 2152; Do sostenido
note_D5       equ 2031; Re
note_Dsharp5  equ 1917; Re sostenido
note_E5       equ 1809; Mi
note_F5       equ 1715; Fa
note_Fsharp5  equ 1612; Fa sostenido
note_G5       equ 1521; Sol
note_Gsharp5  equ 1436; Sol sostenido
note_A5       equ 1355; La
note_Asharp5  equ 1292; La sostenido
note_B5       equ 1207; Si
note_C6       equ 1140; Do

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
        
         CALL piano;se "manda" el AL del getch
        
    JMP while1   
    eliwh1:

    song_2

exit
main ENDP
piano PROC
         CMP AL,1Bh;'esc' 
         JNE et_continue
         JMP eliwh1

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
                   putch '#'
                   beep note_Csharp3, int16_sostenido
                   JMP break
               c_2:
                   putch 'D'
                   putch '#'
                   beep note_Dsharp3, int16_sostenido
                   JMP break
               c_3:
                   JMP break
               c_4:
                   putch 'F'
                   putch '#'
                   beep note_Fsharp3, int16_sostenido
                   JMP break
               c_5:
                   putch 'G'
                   putch '#'
                   beep note_Gsharp3, int16_sostenido
                   JMP break
               c_6:
                   putch 'A'
                   putch '#'
                   beep note_Asharp3, int16_sostenido
                   JMP break
               c_7:
               c_8:
               c_9:
               c_0:
               case_default:
                   JMP break 

         switch_letters:
               q:
                   putch 'C'
                   beep note_C3, int16_sostenido
                   JMP break
               w:
                   putch 'D'
                   beep note_D3, int16_sostenido
                   JMP break
               e:
                   putch 'E'
                   beep note_E3, int16_sostenido
                   JMP break
               r:
                   putch 'F'
                   beep note_F3, int16_sostenido
                   JMP break
               t:
                   putch 'G'
                   beep note_G3, int16_sostenido
                   JMP break
               y:
                   putch 'A'
                   beep note_A3, int16_sostenido
                   JMP break
               u:
                   putch 'B'
                   beep note_B3, int16_sostenido
                   JMP break
               i:
               o:
               p:
                   JMP break
               a:
                   putch 'C'
                   putch '#'
                   beep note_Csharp4, int16_sostenido
                   JMP break
               s:
                   putch 'D'
                   putch '#'
                   beep note_Dsharp4, int16_sostenido
                   JMP break
               d:
                   JMP break
               f:
                   putch 'F'
                   putch '#'
                   beep note_Fsharp4, int16_sostenido
                   JMP break
               g:
                   putch 'G'
                   putch '#'
                   beep note_Gsharp4, int16_sostenido
                   JMP break
               h:
                   putch 'A'
                   putch '#'
                   beep note_Asharp4, int16_sostenido
                   JMP break
               j:
               k:
               l:
                   JMP break
               z:
                   putch 'C'
                   beep note_C4, int16_sostenido
                   JMP break
               x:
                   putch 'D'
                   beep note_D4, int16_sostenido
                   JMP break
               c:
                   putch 'E'
                   beep note_E4, int16_sostenido
                   JMP break
               v:
                   putch 'F'
                   beep note_F4, int16_sostenido
                   JMP break
               b:
                   putch 'G'
                   beep note_G4, int16_sostenido
                   JMP break
               n:
                   putch 'A'
                   beep note_A4, int16_sostenido
                   JMP break
               m:
                   putch 'B'
                   beep note_B4, int16_sostenido
                   JMP break
               default:
         break:
         putch ' ';
         
RET
piano ENDP

END;code segment
