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
getchar MACRO 
    ;servicio 01 de la int 21h
    ;entrada de caracter con echo
    MOV AH,01h  ;return en AL
    INT 21h
ENDM 
gets MACRO buff_str 
;          TamMax,longUsada,esa longUsada DUPlicalos con el valor '?' 
;buffer DB 255   ,    ?    ,255 DUP(?); reserva un buffer de 255 chars
    MOV AH,0Ah      
    LEA DX, buff_str
    INT 21h
ENDM
puts MACRO buff_str
        XOR BX, BX
		MOV BL, buff_str[1]
		MOV buff_str[BX+2], '$';agrega terminador de cadena
		;MOV DX, OFFSET buff_str + 2; apunta al string del buffer
		LEA DX, buff_str + 2
		MOV AH, 09h
		int 21h
ENDM
pause MACRO
    MOV AH,08h;entrada char sin echo
    INT 21h  
ENDM    
exit MACRO
    MOV AH,4Ch
    INT 21h 
ENDM

kbhit MACRO
    MOV AH, 01h 
    INT 16h
ENDM

getch MACRO ;return en AL
    MOV AH,00h
    INT 16h
ENDM

drawPixel MACRO 
;int8_color int8_pagina int16_x int16_y
;Video mode 13h
    ;servicio 0Ch de la int 10h
    MOV AH,0Ch  ;
    ;MOV AL,int8_color; mover AL el color
    ;MOV BH,int8_pagina   ; BH pagina
    ;MOV CX,int16_x  ; columnas
    ;MOV DX,int16_y  ; filas
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
    MOV DH,24  ;row lower right corner ;25 caracteres
    MOV DL,79  ;col lower right corner ;80 caracteres
    INT 10h       
ENDM 
gotoxy MACRO
;args DL=x,DH=y
    MOV AH,02h
    INT 10h 
ENDM 
drawBlocks MACRO
;args
;BH = pagina
;CX = veces a escribir
    MOV DL,01h;foreground
    MOV DH,01h;background
    MOV AH,09h
    MOV AL,219;caracter 
    MOV BL,DH
    SHL BL,4
    OR  BL,DL;rango  color
    INT 10h    
ENDM

absolut MACRO
;args AX
;return AX
    ;(a XOR b ) - b ,
    ; b = BX = X >> sizeof(int) ; 16 bits es 15, 0 a 15 = 16
    ; a = AX 
    MOV BX,AX
    SAR BX,15;shift aritmetico pq se manejan signos
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
;max y min inspirados en:
porDiez MACRO
;args DX
;return DX
    ;n<<3 + n<<1 = n*8 + n*2 = n*10  (ingenio propio :p)
    PUSH AX
    PUSH CX
    MOV CL,03h
    MOV AX,DX
    SHL DX,CL
    SHL AX,1
    ADD DX,AX
    POP CX
    POP AX
ENDM

sleep MACRO int16_miliseconds
         XOR CX,CX
         MOV AX,int16_miliseconds
         MOV BX,10
         
         XOR DX,DX
         DIV BX
         
         porDiez;DX*10
         MOV CX,DX
         
         XOR DX,DX
         DIV BX
         
         ADD CX,DX
                 
         MOV DX,CX 
         porDiez;
         porDiez;
         porDiez;DX*1000
         MOV CX,AX 
         XOR   AL,AL
         MOV   AH, 86H
         INT   15H
ENDM

beep MACRO int16_frequency, int16_duration
    mov     al, 182         ; Prepare the speaker
    out     43h, al
    mov     ax, int16_frequency   ; Load frequency number
    out     42h, al         ; Output low byte
    mov     al, ah          ; Output high byte
    out     42h, al

    in      al, 61h         ; Turn on note
    OR      al,00000011b   ; Set bits 1 and 0
    out     61h, al

    sleep int16_duration 

    in      al, 61h         ; Turn off note
    and     al, 11111100b   ; Reset bits 1 and 0
    out     61h, al
ENDM