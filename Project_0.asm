
; Project_0: Arithmetic Calculator
 
; Name: Ahmed Mohamed Salah El-Dein Radwan
; ID  : 39


org 100h

; add your code here
                                   
jmp start  
                  
; Messages   
                          
; define variables:

 msg0 db 0Dh,0Ah, " My Calculator performs Arithmetic operations to unsigned integers only  $"
 msg1 db 0Dh,0Ah, " Please Enter the First Number : $"                 
 msg2 db 0Dh,0Ah, " Select one of the following Operations: (+ - * /) or q to quit : $"                 
 msg3 db 0Dh,0Ah, " Now Enter the Second Number : $"                 
 msg4 db 0Dh,0Ah, " The result =  : $"                 
 msg5 db 0Dh,0Ah, " Do you want to perform Another Operation ? (Press y for yes otherwise for no) : $"                 
 msg6 db 0Dh,0Ah, " Good Bye :D  $"                 
 msg7 db 0Dh,0Ah, " Welcome Again : $"                 
 msg8 db 0Dh,0Ah, " Zero $"                 
 
 ; Operators
OPR   db   0

; first and second number:
NUM_1  dw   0 
NUM_2  dw   0
RESULT dw   0
                  
                   
start: 

; Welcoming Message
lea dx, msg0
mov ah, 09h    
int 21h        

start_1: 

MOV Ax,0
MOV dx, 0

; Ask the user for First Number
lea dx, msg1
mov ah, 09h    
int 21h        

mov BX, 0  

mov dl, 10  

scanNum_1:
              
            mov ah, 01h
            int 21h

            cmp al, 13   ; Check if user pressed ENTER KEY
            je  exit_1 

            mov ah, 0  
            sub al, 48   ; ASCII to DECIMAL

            mov cl, al
            mov al, bl   ; Store the previous value in AL

          
            mul dl       ; multiply the previous value with 10

            add al, cl   ; previous value + new value ( after previous value is multiplyed with 10 )
            mov bl, al

            jmp scanNum_1    

exit_1:    
            mov BH,0
            mov NUM_1,BX
            
      
; Ask the user for Second Number
lea dx, msg3
mov ah, 09h    
int 21h        
         
mov BX, 0

mov dl, 10  

scanNum_2:
              
            mov ah, 01h
            int 21h

            cmp al, 13   ; Check if user pressed ENTER KEY
            je  exit_2 

            mov ah, 0  
            sub al, 48   ; ASCII to DECIMAL

            mov cl, al
            mov al, bl   ; Store the previous value in AL

          
            mul dl       ; multiply the previous value with 10

            add al, cl   ; previous value + new value ( after previous value is multiplyed with 10 )
            mov bl, al

            jmp scanNum_2    

exit_2:    
            mov BH,0
            mov NUM_2,BX


; get operator: 
lea dx, msg2
mov ah, 09h    
int 21h        

mov dl, 10  


mov ah, 1   ; single char input to AL.
int 21h
mov opr, al


cmp opr, 'q'      ; q - exit in the middle.
je exit

cmp opr, 'Q'      ; q - exit in the middle.
je exit


cmp opr, '+'
je do_plus  


cmp opr, '-'
je do_minus


cmp opr, '*'
je do_mult  


cmp opr, '/'
je do_div

            
            
; calculate:

cmp opr, '+'
je do_plus

cmp opr, '-'
je do_minus

cmp opr, '*'
je do_mult

cmp opr, '/'
je do_div

jmp exit


;Operations

do_plus:


mov ax, NUM_1
add ax, NUM_2
MOV RESULT,AX

jmp Operation_Complete



do_minus:

mov ax, NUM_1
SUB ax, NUM_2
MOV RESULT,AX

jmp Operation_Complete  


do_mult:

mov ax, NUM_1
mul NUM_2 ; (dx ax) = ax * num2. 
MOV RESULT,AX

jmp Operation_Complete




do_div:
mov dx, 0
mov ax, NUM_1
div NUM_2  ; ax = (dx ax) / num2.
MOV RESULT,AX

jmp Operation_Complete



Operation_Complete:

lea dx,  msg4
mov ah, 09h
int 21h      


;Print the result
              
             MOV AX,RESULT  
             
             ;Check if the result = 0
             cmp AX, 0
             JE print_zero 

             
             ;Print the Key  
             CALL PRINT 
             
             jmp next_step


print_zero: lea dx,  msg8
            mov ah, 09h
            int 21h    


next_step:             
             
;Ask the User whether he wants to perform Another Operation                  
lea dx,  msg5
mov ah, 09h
int 21h    
 
; get operator:
mov ah, 1   ; single char input to AL.
int 21h
mov opr, al
 

cmp opr, 'y' 
je Another_operation

cmp opr, 'Y' 
je Another_operation


jmp exit

Another_operation: lea dx,  msg7
                   mov ah, 09h
                   int 21h    
                   jmp start_1


exit:
lea dx, msg6
mov ah, 09h
int 21h  


ret  ; return back to os.


PRINT PROC            
      
    ;initilize count 
    mov cx,0 
    mov dx,0 
    label1: 
        ; if ax is zero 
        cmp ax,0 
        je print1       
          
        ;initilize bx to 10 
        mov bx,10         
          
        ; extract the last digit 
        div bx                   
          
        ;push it in the stack 
        push dx               
          
        ;increment the count 
        inc cx               
          
        ;set dx to 0  
        xor dx,dx 
        jmp label1 
    print1: 
        ;check if count  
        ;is greater than zero 
        cmp cx,0 
        je exit_print
          
        ;pop the top of stack 
        pop dx 
          
        ;add 48 so that it  
        ;represents the ASCII 
        ;value of digits 
        add dx,48 
          
        ;interuppt to print a 
        ;character 
        mov ah,02h 
        int 21h 
          
        ;decrease the count 
        dec cx 
        jmp print1 
exit_print: 
ret 
PRINT ENDP   


























