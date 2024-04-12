.model small

.stack 100h

.data
include "mac.inc"

buff_input DB 10,?,10 DUP(?)
int16_var1 DW 0
int8_var2 DB 0
str_string1 DB "hola mundo",'$'
str_string2 DB "preciona a",'$'

.code
MOV AX,@DATA
MOV DS,AX

main PROC

   ;gets buff_input
   ;endl
   ;puts buff_input
   ;print str_string1
   ;endl
    
   while:
        print str_string2
        endl
        
        kbhit 
        JZ while
          
        getch
        CMP AL,'a' 
        JE eliwh  
       
        
    JMP while   
    eliwh:
               
exit
main ENDP

END;code segment