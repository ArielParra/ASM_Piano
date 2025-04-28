endl MACRO
    MOV AH,02h
    MOV DL,13 
    INT 21h
    MOV DL, 10 
    INT 21h
ENDM 
print MACRO str_msg
    MOV AH, 09h
    LEA DX, str_msg  
    INT 21h
ENDM 
putch MACRO char_ch    
    MOV AH,02h    
    MOV DL,char_ch
    INT 21h   
ENDM
putchC MACRO char_ch,color,n,page
    MOV AH,09h
    MOV AL,char_ch
    MOV BH,page
    MOV BL,color
    MOV CX,n
    INT 10h
ENDM
getchar MACRO 
    ;servicio 01 de la int 21h
    ;echo character input
    MOV AH,01h  ;return en AL
    INT 21h
ENDM 
gets MACRO buff_str 
;         MaxSize,usedSize, DUPlicated value '?' 
;buffer DB 255   ,    ?    ,255 DUP(?);  255 char buffer
    MOV AH,0Ah      
    LEA DX, buff_str
    INT 21h
ENDM
puts MACRO buff_str
        XOR BX, BX
		MOV BL, buff_str[1]
		MOV buff_str[BX+2], '$'; adds str terminator
        ;MOV DX, OFFSET buff_str[2]; points to the string in the buffer
		LEA DX, buff_str + 2
		MOV AH, 09h
		int 21h
ENDM
pause MACRO
    MOV AH,08h;char input w/o echo
    INT 21h  
ENDM    
exit MACRO
    MOV AX,03h
    INT 10h
    MOV AH,4Ch
    INT 21h 
ENDM

kbhit MACRO
    MOV AH, 01h 
    INT 16h
ENDM

getch MACRO ;returns in AL
    MOV AH,00h
    INT 16h
ENDM

drawPixel MACRO 
;int8_color int8_pag int16_x int16_y
;Video mode 13h
    ;service 0Ch of int 10h
    MOV AH,0Ch  ;
    ;MOV AL,int8_color; move AL color
    ;MOV BH,int8_pag  ; BH page
    ;MOV CX,int16_x   ; column
    ;MOV DX,int16_y   ; rows
    INT 10h
ENDM   
setVideo MACRO int8_modo
    ;00h text  40x25, 16 colors, 8 pages
    ;13h video 40x25, 256 colors, 320x200 px
    MOV AH,00h
    MOV AL,int8_modo
    INT 10h
ENDM     
setPag MACRO int8_pag
    MOV AH,05h
    MOV AL,int8_pag
    INT 10h
ENDM
setBG MACRO
;args BH = color (BG,FG)
    MOV AH,07h
    MOV AL,0h  ;lines to scroll  (00h = clear)
    MOV BH,24h ;attribute 
    MOV CH,0   ;row upper left corner 
    MOV CL,0   ;col upper left corner
    MOV DH,24  ;row lower right corner ;25 chars
    MOV DL,79  ;col lower right corner ;80 chars
    INT 10h       
ENDM 
gotoxy MACRO x,y,page
;args DL=x,DH=y
    MOV DH,y
    MOV DL,x
    MOV BH,page
    MOV AH,02h
    INT 10h 
ENDM 
drawBlocks MACRO
;args
;BH = page
;CX = times to write
    MOV DL,01h;foreground
    MOV DH,01h;background
    MOV AH,09h
    MOV AL,219;character Block 
    MOV BL,DH
    SHL BL,4
    OR  BL,DL;color range
    INT 10h    
ENDM

absolut MACRO
;args AX
;return AX
    ;(a XOR b ) - b ,
    ; b = BX = X >> sizeof(int) ; 16 bits es 15, 0 a 15 = 16
    ; a = AX 
    MOV BX,AX
    SAR BX,15;Arithmetic shift cause of the sign
    XOR AX,BX
    SUB AX,BX
ENDM 
max MACRO
;args AX,BX
;return AX
    ;x - ( (x - y) & ((x - y) >> sizeof(int)) )
    MOV DX,AX
    SUB DX,BX;DX = (x - y)
    MOV BX,DX
    SAR BX,15;BX = (x - y) >> 15
    AND DX,BX
    ; x -  ((x - y) & ((x - y) >> 15
    SUB AX,BX
ENDM
min MACRO
;args AX,BX
;return AX
    ; ( (x - y) & ( (x - y) >> sizeof(int)) ) + y 
    SUB AX,BX;AX = (x - y)  
    MOV DX,AX
    SAR DX,15;Dx = (x - y) >> 15
    AND AX,DX
    ADD AX,BX
ENDM

byTen MACRO; 14 cpu cycles insted of 118 cycles from MUL 10
;args DX
;return DX
    ;n<<3 + n<<1 = n*8 + n*2 = n*10  
    ;(Ariel Parra invention to multiply by 10)
    PUSH AX
    PUSH CX
    MOV CL,03h; Fixes error in dosbox
    MOV AX,DX
    SHL DX,CL
    SHL AX,1
    ADD DX,AX
    POP CX
    POP AX
ENDM

sleep MACRO int16_milliseconds
         XOR CX,CX
         MOV AX,int16_milliseconds
         MOV BX,10
         XOR DX,DX
         DIV BX
         byTen;DX*10
         MOV CX,DX
         XOR DX,DX
         DIV BX
         ADD CX,DX 
         MOV DX,CX 
         byTen;
         byTen;
         byTen;DX*1000
         MOV CX,AX 
         XOR   AL,AL
         MOV   AH, 86H
         INT   15H
ENDM

beep_on MACRO
    MOV     AL, 182         ; Prepare the speaker
    OUT     43h, AL
    MOV     AX, BX          ; Load frequency number from BX
    OUT     42h, AL         ; Output low byte
    MOV     AL, AH          ; Output high byte
    OUT     42h, AL
    IN      AL, 61h         ; Turn on note
    OR      AL,00000011b    ; Set bits 1 and 0
    OUT     61h, AL
ENDM

beep_off MACRO
    IN      AL, 61h         ; Turn off note
    AND     AL, 11111100b   ; Reset bits 1 and 0
    OUT     61h, AL
ENDM

scrollUP MACRO filSup, colSup, filInf, colInf, color
    MOV AH,06
    MOV AL,0
    MOV BH,color
    MOV CH,filSup
    MOV CL,colSup
    MOV DH,filInf
    MOV DL,colInf       
    INT 10h
ENDM