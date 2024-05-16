.model small

.stack 100h

.data
include mac.inc
include song.inc


;variables
buff_input DB 10,?,10 DUP(?)
int16_aux DW 0
int8_var2 DB 0
str_string0 DB "1. piano, 2. caja musical, 3. salir: ",'$';
str_string1 DB "presiona numeros y letras para sonido y esc para salir",'$';
str_string2 DB "1. Mario, 2. Zelda SOT, 3.Fur Elise, 4. Despacito: ",'$';
int16_sostenido DW 800;ms
;constantes

jumpTable_menu    DW et_default,et_piano,et_jukebox,et_salir;
jumpTable_jukebox DW case_default,case_song_1,case_song_2,case_song_3,case_song_4;
jumpTable_numbers DW c_0,c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_default;
jumpTable_letters DW a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,default;

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
note_F5       equ 1708; Fa 
note_Fsharp5  equ 1612; Fa sostenido
note_G5       equ 1521; Sol
note_Gsharp5  equ 1436; Sol sostenido
note_A5       equ 1355; La
note_Asharp5  equ 1279; La sostenido
note_B5       equ 1207; Si
note_C6       equ 1140; Do


.code
MOV AX,@DATA
MOV DS,AX

main PROC
    while0:
    endl
    print str_string0;
    getch
    XOR AH,AH
        SUB AL, '0'
        CMP AX,3
        JLE et_switch_validado
        MOV AX,0;default

        et_switch_validado:
            SHL AX,1
            LEA BX,jumpTable_menu
            ADD BX,AX;indice ya validado
            JMP [BX]

        switch_menu:
            et_piano:
                CALL piano
            et_default:
                jmp while0;
            et_jukebox:
                CALL jukebox
                jmp et_default;
            et_salir:
                exit
            
    JMP while0
    eliwh0:

main ENDP

piano PROC
    endl
    print str_string1;presiona numeros y letras para sonido y esc para salir
    while1:
        
        kbhit 
        JZ while1
          
        getch
        XOR AH, AH
        
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
                   beep note_Csharp3, int16_sostenido
                   JMP break
               c_2:
                   beep note_Dsharp3, int16_sostenido
                   JMP break
               c_3:
                   JMP break
               c_4:
                   beep note_Fsharp3, int16_sostenido
                   JMP break
               c_5:
                   beep note_Gsharp3, int16_sostenido
                   JMP break
               c_6:
                   beep note_Asharp3, int16_sostenido
                   JMP break
               c_7:
               c_8:
               c_9:
               c_0:
               c_default:
                   JMP break 
         switch_letters:
               q:
                   beep note_C3, int16_sostenido
                   JMP break
               w:
                   beep note_D3, int16_sostenido
                   JMP break
               e:
                   beep note_E3, int16_sostenido
                   JMP break
               r:
                   beep note_F3, int16_sostenido
                   JMP break
               t:
                   beep note_G3, int16_sostenido
                   JMP break
               y:
                   beep note_A3, int16_sostenido
                   JMP break
               u:
                   beep note_B3, int16_sostenido
                   JMP break
               i:
               o:
               p:
                   JMP break
               a:
                   beep note_Csharp4, int16_sostenido
                   JMP break
               s:
                   beep note_Dsharp4, int16_sostenido
                   JMP break
               d:
                   JMP break
               f:
                   beep note_Fsharp4, int16_sostenido
                   JMP break
               g:
                   beep note_Gsharp4, int16_sostenido
                   JMP break
               h:
                   beep note_Asharp4, int16_sostenido
                   JMP break
               j:
               k:
               l:
                   JMP break
               z:
                   beep note_C4, int16_sostenido
                   JMP break
               x:
                   beep note_D4, int16_sostenido
                   JMP break
               c:
                   beep note_E4, int16_sostenido
                   JMP break
               v:
                   beep note_F4, int16_sostenido
                   JMP break
               b:
                   beep note_G4, int16_sostenido
                   JMP break
               n:
                   beep note_A4, int16_sostenido
                   JMP break
               m:
                   beep note_B4, int16_sostenido
                   JMP break
               default:
         break:

    JMP while1   
    eliwh1:
RET
piano ENDP

jukebox PROC
    endl
    print str_string2;1. Mario, 2. Zelda SOT, 3.Fur Elise, 4. Despacito
    getch
    XOR AH,AH
        SUB AL,'0'
        CMP AX,4
        JLE et_jukebox_validado
        MOV AX,0;default

        et_jukebox_validado:
            SHL AX,1
            LEA BX,jumpTable_jukebox
            ADD BX,AX;indice ya validado
            JMP [BX]

        switch_jukebox:
            case_song_1:
                CALL play_song_1
                RET
            case_song_2:
                CALL play_song_2
                RET
            case_song_3:
                CALL play_song_3
            case_song_4:
                CALL play_song_4
                RET
            case_default:
                RET
jukebox ENDP

play_song_1 PROC
    song_1
RET
play_song_1 ENDP
play_song_2 PROC
    song_2
RET
play_song_2 ENDP
play_song_3 PROC
    song_3
RET
play_song_3 ENDP
play_song_4 PROC
    song_4
RET
play_song_4 ENDP

END;code segment