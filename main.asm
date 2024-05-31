.model small

.stack 100h

.data
include mac.inc
include song.inc

;variables
int16_delay DW 0;ms

xpos        DB  0
ypos        DB  0
x2pos       DB  0
y2pos       DB  0
aux         DB  0   

;jump / branch  tables
jumpTable_menu    DW et_default,et_piano,et_jukebox;
jumpTable_jukebox DW case_default,case_song_1,case_song_2,case_song_3,case_song_4;
jumpTable_numbers DW c_0,c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_default;
jumpTable_letters DW a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,default;

;menu principal
str_titulo1    DB    "    ___   ___     _     _  _    ___  ",'$'
str_titulo2    DB    "   | _ \ |_ _|   /_\   | \| |  / _ \ ",'$' 
str_titulo3    DB    "   |  _/  | |   / _ \  | .` | | (_) |",'$'
str_titulo4    DB    "   |_|   |___| /_/ \_\ |_|\_|  \___/ ",'$'
str_titulo5    DB    "                           _     ___   __  __ ",'$'
str_titulo6    DB    "                          /_\   / __| |  \/  | ",'$'
str_titulo7    DB    "                     _   / _ \  \__ \ | |\/| | ",'$'
str_titulo8    DB    "                    |_| /_/ \_\ |___/ |_|  |_|",'$'

str_piano1  DB    "                                               ____________                   ",'$'
str_piano2  DB    "                                              /            |                  ",'$'
str_piano3  DB    "                                        _____/            /-----\----------,  ",'$'
str_piano4  DB    "                                    ____|________________|___________/-----|  ",'$'
str_piano5  DB    "                                   (//_///_//_///_//_///_//_///_//_///)     | ",'$'
str_piano6  DB    "                                   /---------------------------------/_____/  ",'$'
str_piano7  DB    "                                         |   | -------    |          | |      ",'$'
str_piano8  DB    "                                         |  |        |  |            ||       ",'$'
str_piano9  DB    "                                          ||          | |                     ",'$'
str_piano10  DB   "                                                       ||                     ",'$'

str_integrantes1 DB  "Integrantes: ", '$'
str_integrantes2 DB  "Miguel Angel Batres Luna",'$'
str_integrantes3 DB  "Ariel Emilio Parra Martinez",'$'
str_integrantes4 DB  "Diego Ivan Salas Pedroza",'$'

str_menu1   DB  "Selecciona una opcion: ",'$'
str_menu2   DB  "1. Piano",'$'
str_menu3   DB  "2. Caja Musical",'$'
str_menu4   DB  "ESC. Salir",'$'

;Pantalla piano
str_juego   DB "Presione ESC para salir", '$'

;menu de canciones
str_songMenu1  DB "REPERTORIO",'$'
str_songMenu2  DB "Mario",'$'
str_songMenu3  DB "Zelda SOT",'$'
str_songMenu4  DB "Fur Elise",'$'
str_songMenu5  DB "Despacito",'$'
str_songMenu6  DB "ESC. salir",'$'
str_songMenu7  DB  "       |\",'$'
str_songMenu8  DB  "    |--|/--------------------,~\-----------(_)------|~~~~|----,~\---------|",'$'
str_songMenu9  DB  "    |--|---4-----------------|~'------------|------_|---_|----|~----------|",'$'
str_songMenu10 DB  "    |-/|.-----------|~~~~|--/|-------------/|-----(_)--(_)---/|----(_)----|",'$'
str_songMenu11 DB  "    |(-|-)-4-------_|---_|--\|-----|~~~~|--\|----------------\|-----|-----|",'$'
str_songMenu12 DB  "    |-`|'---------(_)--(_)--------_|---_|--------------------------/|-----|",'$'
str_songMenu13 DB  "      \|                         (_)--(_)                          \|      ",'$'

;Colors
black       DB  0
darkBlue    DB  1
green       DB  2
lightBlue   DB  3
red         DB  4
purple      DB  5
brown       DB  6
gray        DB  7
darkGray    DB  8
blue        DB  9
LimeGreen   DB  10
skyBlue     DB  11
lightRed    DB  12
pink        DB  13
yellow      DB  14
white       DB  15

;notes
note_C          DB  "DO",'$'
note_CSharp     DB  "DO#",'$'
note_D          DB  "RE",'$'
note_DSharp    DB  "RE#",'$'
note_E          DB  "MI",'$'
note_F          DB  "FA",'$'
note_FSharp    DB  "FA#",'$'
note_G          DB  "SOL",'$'
note_GSharp    DB  "SOL#",'$'
note_A          DB  "LA",'$'
note_ASharp    DB  "LA#",'$'
note_B          DB  "SI",'$'

;note constants
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
        CALL menu
        getch
        XOR AH,AH
        CMP AL,1Bh;'esc' 
        JNE et_continue0
        exit;salir presionando esc

        et_continue0:
        SUB AL,'0';to number
        CMP AX,2
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
                jmp et_break0;
            et_jukebox:
                CALL jukebox
            et_break0:

    JMP while0
    eliwh0:

main ENDP

piano PROC
    CALL pantallaPiano
    MOV int16_delay,200;ms 
    while1:
        
        kbhit 
        JZ while1
          
        getch
        XOR AH, AH
        
        CMP AL,1Bh;'esc' 
        JNE et_continue1
        JMP eliwh1

        et_continue1:

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
                JMP break1
            c_2:
                MOV BX, note_Csharp3
                CALL beep_proc
                JMP break1
            c_3:
                MOV BX, note_Dsharp3
                CALL beep_proc
                JMP break1
            c_4:
                JMP break1
            c_5:
                MOV BX, note_Fsharp3
                CALL beep_proc
                JMP break1
            c_6:
                MOV BX, note_Gsharp3
                CALL beep_proc
                JMP break1
            c_7:
                MOV BX, note_Asharp3
                CALL beep_proc
                JMP break1
            c_8:
            c_9:
            c_0:
            c_default:
                JMP break1
            
            break1:
                jmp break2; jumps to the switch_letters break2;

        switch_letters:
            q:
                MOV BX, note_C3
                CALL beep_proc
                JMP break2
            w:
                MOV BX, note_D3
                CALL beep_proc
                JMP break2
            e:
                MOV BX, note_E3
                CALL beep_proc
                JMP break2
            r:
                MOV BX, note_F3
                CALL beep_proc
                JMP break2
            t:
                MOV BX, note_G3
                CALL beep_proc
                JMP break2
            y:
                MOV BX, note_A3
                CALL beep_proc
                JMP break2
            u:
                MOV BX, note_B3
                CALL beep_proc
                JMP break2
            i:
            o:
            p:
                JMP break2
            a:
                JMP break2
            s:
                MOV BX, note_Csharp4
                CALL beep_proc
                JMP break2
            d:
                MOV BX, note_Dsharp4
                CALL beep_proc
                JMP break2
            f:
                JMP break2
            g:
                MOV BX, note_Fsharp4
                CALL beep_proc
                JMP break2
            h:
                MOV BX, note_Gsharp4
                CALL beep_proc
                JMP break2
            j:
                MOV BX, note_Asharp4
                CALL beep_proc
                JMP break2
            k:
            l:
                JMP break2
            z:
                MOV BX, note_C4
                CALL beep_proc
                JMP break2
            x:
                MOV BX, note_D4
                CALL beep_proc
                JMP break2
            c:
                MOV BX, note_E4
                CALL beep_proc
                JMP break2
            v:
                MOV BX, note_F4
                CALL beep_proc
                JMP break2
            b:
                MOV BX, note_G4
                CALL beep_proc
                JMP break2
            n:
                MOV BX, note_A4
                CALL beep_proc
                JMP break2
            m:
                MOV BX, note_B4
                CALL beep_proc
                JMP break2
            default:
        break2:

    JMP while1   
    eliwh1:
RET
piano ENDP

beep_proc PROC
    beep_on
    sleep int16_delay
    beep_off
RET
beep_proc ENDP

jukebox PROC
    CALL menuCanciones
    while2:
        getch
        XOR AH,AH
          
        CMP AL,1Bh;'esc' 
        JNE et_continue2
        JMP eliwh2
        
        et_continue2:
        SUB AL,'0'
        CMP AX,4
        JLE et_salto_validado
        MOV AX,0;default

        et_salto_validado:
            SHL AX,1
            LEA BX,jumpTable_jukebox
            ADD BX,AX;indice ya validado
            JMP [BX]

        switch_jukebox:
            case_song_1:
                song_1
                JMP while2
            case_song_2:
                song_2
                JMP case_default
            case_default:
                JMP while2
            case_song_3:
                song_3
                JMP case_default
            case_song_4:
                song_4
                JMP case_default
    eliwh2:
RET
jukebox ENDP

menu PROC
    MOV AH,00
    MOV AL,10h ;Modo de video
    INT 10h
    
    ;Imprimir el titulo del menu de inicio

    MOV BL,skyBlue
    gotoxy 0,3,0
    LEA SI,str_titulo1
    CALL imprimirColor
    gotoxy 0,4,0
    LEA SI,str_titulo2
    CALL imprimirColor
    gotoxy 0,5,0
    LEA SI,str_titulo3
    CALL imprimirColor    
    gotoxy 0,6,0
    LEA SI,str_titulo4
    CALL imprimirColor

    MOV BL,green
    gotoxy 0,7,0
    LEA SI,str_titulo5
    CALL imprimirColor
    gotoxy 0,8,0
    LEA SI,str_titulo6
    CALL imprimirColor
    gotoxy 0,9,0
    LEA SI,str_titulo7
    CALL imprimirColor
    gotoxy 0,10,0
    LEA SI,str_titulo8
    CALL imprimirColor

    MOV BH,0
    MOV DH,13
    MOV DL,0
    MOV AH,02h
    INT 10h
    print str_piano1
    endl
    print str_piano2
    endl
    print str_piano3
    endl
    print str_piano4
    endl
    print str_piano5
    endl
    print str_piano6
    endl
    print str_piano7
    endl
    print str_piano8
    endl
    print str_piano9
    endl
    print str_piano10  
    
    MOV BL,darkBlue
    gotoxy 5,15,0
    LEA SI,str_menu1
    CALL imprimirColor
    MOV BL,white
    gotoxy 5,16,0
    LEA SI,str_menu2
    CALL imprimirColor
    gotoxy 5,17,0
    LEA SI,str_menu3
    CALL imprimirColor
    MOV BL,gray
    gotoxy 5,18,0
    LEA SI,str_menu4
    CALL imprimirColor

    MOV BL,red
    gotoxy 55,3,0
    LEA SI,str_integrantes1
    CALL imprimirColor
    MOV BL,white
    gotoxy 48,4,0
    LEA SI,str_integrantes2
    CALL imprimirColor
    gotoxy 48,5,0
    LEA SI,str_integrantes3
    CALL imprimirColor
    gotoxy 48,6,0
    LEA SI,str_integrantes4
    CALL imprimirColor
    RET
menu ENDP

pantallaPiano PROC
    MOV AH,05 ;Cambiar de pagina
    MOV AL,01 
    INT 10h

    endl
    endl
    print str_juego

    MOV ypos, 5
    MOV xpos, 5
    MOV y2pos, 20
    MOV x2pos, 74
    scrollUP ypos,xpos,y2pos,x2pos,white

    DEC xpos
    pintarLineas:
        ADD xpos,5
        scrollUP ypos,xpos,y2pos,xpos,black
        CMP xpos, 74
        JNE pintarLineas  
    
    MOV xpos,8
    MOV x2pos,8
    MOV y2pos,13
    ADD x2pos,2
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 9,ypos,1
    putch '2'

    ADD xpos,5
    ADD x2pos,5
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 14,ypos,1
    putch '3'

    ADD xpos,10
    ADD x2pos,10
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 24,ypos,1
    putch '5'

    ADD xpos,5
    ADD x2pos,5
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 29,ypos,1
    putch '6'

    ADD xpos,5
    ADD x2pos,5
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 34,ypos,1
    putch '7'

    ADD xpos,10
    ADD x2pos,10
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 44,ypos,1
    putch 'S'

    ADD xpos,5
    ADD x2pos,5
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 49,ypos,1
    putch 'D'

    ADD xpos,10
    ADD x2pos,10
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 59,ypos,1
    putch 'G'

    ADD xpos,5
    ADD x2pos,5
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 64,ypos,1
    putch 'H'
    
    ADD xpos,5
    ADD x2pos,5
    scrollUP ypos,xpos,y2pos,x2pos,black
    gotoxy 69,ypos,1
    putch 'J'

    MOV BL,LimeGreen
    gotoxy 8,4,1
    LEA SI,note_CSharp
    CALL imprimirColor
    gotoxy 13,4,1
    LEA SI,note_DSharp
    CALL imprimirColor
    gotoxy 23,4,1
    LEA SI,note_FSharp
    CALL imprimirColor
    gotoxy 28,4,1
    LEA SI,note_GSharp
    CALL imprimirColor
    gotoxy 33,4,1
    LEA SI,note_ASharp
    CALL imprimirColor
    gotoxy 6,22,1
    LEA SI,note_C
    CALL imprimirColor
    gotoxy 11,22,1
    LEA SI,note_D
    CALL imprimirColor
    gotoxy 16,22,1
    LEA SI,note_E
    CALL imprimirColor
    gotoxy 21,22,1
    LEA SI,note_F
    CALL imprimirColor
    gotoxy 26,22,1
    LEA SI,note_G
    CALL imprimirColor
    gotoxy 31,22,1
    LEA SI,note_A
    CALL imprimirColor
    gotoxy 36,22,1
    LEA SI,note_B
    CALL imprimirColor

    MOV BL,lightBlue
    gotoxy 43,4,1
    LEA SI,note_CSharp
    CALL imprimirColor
    gotoxy 48,4,1
    LEA SI,note_DSharp
    CALL imprimirColor
    gotoxy 58,4,1
    LEA SI,note_FSharp
    CALL imprimirColor
    gotoxy 63,4,1
    LEA SI,note_GSharp
    CALL imprimirColor
    gotoxy 68,4,1
    LEA SI,note_ASharp
    CALL imprimirColor
    gotoxy 41,22,1
    LEA SI,note_C
    CALL imprimirColor
    gotoxy 46,22,1
    LEA SI,note_D
    CALL imprimirColor
    gotoxy 51,22,1
    LEA SI,note_E
    CALL imprimirColor
    gotoxy 56,22,1
    LEA SI,note_F
    CALL imprimirColor
    gotoxy 61,22,1
    LEA SI,note_G
    CALL imprimirColor
    gotoxy 66,22,1
    LEA SI,note_A
    CALL imprimirColor
    gotoxy 71,22,1
    LEA SI,note_B
    CALL imprimirColor

    gotoxy 6,21,1
    putchC 'Q',white,1,1
    gotoxy 11,21,1
    putchC 'W',white,1,1
    gotoxy 16,21,1
    putchC 'E',white,1,1
    gotoxy 21,21,1
    putchC 'R',white,1,1
    gotoxy 26,21,1
    putchC 'T',white,1,1
    gotoxy 31,21,1
    putchC 'Y',white,1,1
    gotoxy 36,21,1
    putchC 'U',white,1,1
    gotoxy 41,21,1
    putchC 'Z',white,1,1
    gotoxy 46,21,1
    putchC 'X',white,1,1
    gotoxy 51,21,1
    putchC 'C',white,1,1
    gotoxy 56,21,1
    putchC 'V',white,1,1
    gotoxy 61,21,1
    putchC 'B',white,1,1
    gotoxy 66,21,1
    putchC 'N',white,1,1
    gotoxy 71,21,1
    putchC 'M',white,1,1
    RET
pantallaPiano ENDP

menuCanciones PROC
    MOV AH,05 ;Cambiar de pagina
    MOV AL,01
    INT 10h

     
    gotoxy 30,4,1
    putchC '*',yellow,1,1 
    gotoxy 30,6,1
    putchC '*',yellow,1,1 
    gotoxy 30,9,1
    putchC '*',yellow,1,1 
    gotoxy 30,12,1
    putchC '*',yellow,1,1 
    gotoxy 33,3,1
    putchC '*',yellow,1,1 
    gotoxy 38,3,1
    putchC '*',yellow,1,1 
    gotoxy 43,3,1
    putchC '*',yellow,1,1 
    gotoxy 48,3,1
    putchC '*',yellow,1,1 
    gotoxy 51,4,1
    putchC '*',yellow,1,1 
    gotoxy 51,6,1
    putchC '*',yellow,1,1 
    gotoxy 51,9,1
    putchC '*',yellow,1,1 
    gotoxy 51,12,1
    putchC '*',yellow,1,1 

    MOV xpos,32
    MOV x2pos,49
    MOV ypos,4
    borde:
        gotoxy xpos,ypos,1
        putchC 186,pink,1,1 ;­­║­­
        gotoxy x2pos,ypos,1
        putchC 186,pink,1,1 ;║­­­
        INC ypos
        CMP ypos,13
        JNE borde
    gotoxy xpos,4,1
    putchC 201,pink,1,1 ;╔
    gotoxy x2pos,4,1
    putchC 187,pink,1,1 ;╗­­­
    gotoxy xpos,6,1
    putchC 204,pink,1,1 ;╠
    gotoxy x2pos,6,1
    putchC 185,pink,1,1 ;╣
    gotoxy xpos,13,1
    putchC 200,pink,1,1 ;╚
    gotoxy x2pos,13,1
    putchC 188,pink,1,1 ;╝
    gotoxy 34,4,1
    putchC 205,pink,14,1 ;═
    gotoxy 34,6,1
    putchC 205,pink,14,1 ;═
    gotoxy 34,11,1
    putchC 205,pink,14,1 ;═
    gotoxy 33,12,1
    putchC 205,pink,16,1 ;═
    gotoxy 34,7,1
    putchC 175,blue,1,1 ;»
    gotoxy 34,8,1
    putchC 175,blue,1,1 ;»
    gotoxy 34,9,1
    putchC 175,blue,1,1 ;»
    gotoxy 34,10,1
    putchC 175,blue,1,1 ;»
    gotoxy 36,5,1
    MOV BL,skyBlue
    LEA SI,str_songMenu1
    CALL imprimirColor
    gotoxy 36,7,1
    putchC '1',LimeGreen,1,1
    gotoxy 38,7,1
    MOV BL,red
    LEA SI,str_songMenu2
    CALL imprimirColor
    gotoxy 36,8,1
    putchC '2',LimeGreen,1,1
    gotoxy 38,8,1
    MOV BL,green
    LEA SI,str_songMenu3
    CALL imprimirColor
    gotoxy 36,9,1
    putchC '3',LimeGreen,1,1
    gotoxy 38,9,1
    MOV BL,gray
    LEA SI,str_songMenu4
    CALL imprimirColor
    gotoxy 36,10,1
    putchC '4',LimeGreen,1,1
    gotoxy 38,10,1
    MOV BL,lightBlue
    LEA SI,str_songMenu5
    CALL imprimirColor
    gotoxy 36,12,1
    MOV BL,white
    LEA SI,str_songMenu6
    CALL imprimirColor
    
    MOV BL,gray
    gotoxy 0,16,1
    LEA SI,str_songMenu7
    CALL imprimirColor
    gotoxy 0,17,1
    LEA SI,str_songMenu8
    CALL imprimirColor
    gotoxy 0,18,1
    LEA SI,str_songMenu9
    CALL imprimirColor
    gotoxy 0,19,1
    LEA SI,str_songMenu10
    CALL imprimirColor
    gotoxy 0,20,1
    LEA SI,str_songMenu11
    CALL imprimirColor
    gotoxy 0,21,1
    LEA SI,str_songMenu12
    CALL imprimirColor
    gotoxy 0,22,1
    LEA SI,str_songMenu13
    CALL imprimirColor
    RET
menuCanciones ENDP

imprimirColor PROC
    imprimir:
    MOV AH,09
    MOV AL,[SI]
    MOV CX,1
    INT 10h
    INC SI
    INC DL
    MOV AH,02
    INT 10h
    MOV AL,[SI]
    CMP AL,'$'
    JNE imprimir
    RET
imprimirColor ENDP

END;code segment