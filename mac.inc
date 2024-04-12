;Ariel Emilio Parra Martinez ISC 4A ID:280862
endl MACRO
    MOV AH, 02h
    MOV DL, 13 ;\r
    INT 21h
    MOV DL, 10 ;\n
    INT 21h
ENDM 
print MACRO str_msg
    MOV AH, 09h
    MOV DX, OFFSET str_msg  
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
;          TamMax,longUsada,esa longUsada DUPlicalos con el valor '?' (vacio)                         
;buffer DB 255   ,    ?    ,255 DUP(?); reserva un buffer de 255 chars
    MOV AH,0Ah      
    MOV DX,OFFSET buff_str
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

drawPixel MACRO int8_color int8_pagina int16_x int16_y  ;Video mode 13h
    ;servicio 0Ch de la int 10h
    MOV AH,0Ch  ;
    MOV AL,int8_color; mover AL el color
    MOV BH,int8_pagina   ; BH pagina
    MOV CX,int16_x  ; columnas
    MOV DX,int16_y  ; filas
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
    MOV AH,07h
    MOV AL,0h  ;lines to scroll  (00h = clear)
    MOV BH,24h ;attribute 
    MOV CH,0   ;row upper left corner 
    MOV CL,0   ;col upper left corner
    MOV DH,24  ;row lower right corner ;25 caracteres
    MOV DL,79  ;col lower right corner ;80 caracteres
    INT 10h       
ENDM    
gotoxy MACRO int8_x int8_y
    MOV DL,int8_x
    MOV DH,int8_y
    MOV AH,02h
    INT 10h 
ENDM 
drawBlocks MACRO int8_pagina int8_num
    MOV DL,01h;foreground
    MOV DH,01h;background
    MOV AH,09h
    MOV AL,219; caracter 
    MOV BH,int8_pagina; pag
    MOV BL,DH
    SHL BL,4
    OR  BL,DL;rango  color
    MOV CX,int8_num;number time write
    INT 10h    
ENDM


abs MACRO ;input AX, return AX
    ;(a XOR b ) - b ,
    ; b = BX = X >> sizeof(int) ; 16 bits es 15, 0 a 15 = 16
    ; a = AX 
    MOV BX,AX
    SAR BX,15;shift aritmetico pq se manejan signos
    XOR AX,BX
    SUB AX,BX
;inspirado de https://stackoverflow.com/questions/2639173/x86-assembly-abs-implementation
ENDM 
max MACRO int16_x int16_y ;return AX
    ;x - ( (x - y) & ((x - y) >> sizeof(int)) )
    MOV BX,int16_x
    SUB BX,int16_y;BX = (x - y)  
    MOV AX,BX
    SAR AX,15;AX = (x - y) >> 15
    AND BX,AX
    MOV AX,int16_x; x -  ((x - y) & ((x - y) >> 15
    SUB AX,BX
ENDM
min MACRO int16_x int16_y ;return AX                    
    ; ( (x - y) & ( (x - y) >> sizeof(int)) ) + y 
    MOV AX,int16_x
    SUB AX,int16_y;AX = (x - y)  
    MOV BX,AX
    SAR BX,15;BX = (x - y) >> 15
    AND AX,BX
    ADD AX,int16_y
    ;return on AX
ENDM
;max y min inspirados en: https://www.geeksforgeeks.org/compute-the-minimum-or-maximum-max-of-two-integers-without-branching/
porDiez MACRO; entrada y ret on BX
    ;n<<3 + n<<1 = n*8 + n*2 = n*10  (ingenio propio :p)
    MOV DX,BX
    SHL BX,3
    SHL DX,1
    ADD BX,DX
ENDM
swap MACRO; AX con BX
    XCHG AX,BX
ENDM     
