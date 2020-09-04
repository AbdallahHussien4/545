Delay MACRO        ;Make delay 
          
    push ax
    push cx 
    push dx   
      
    MOV CX, 7H       
    MOV DX, 0a120H
    MOV AH, 86H
 

 
    INT 15H   
    pop dx
    pop cx
    pop ax
 
ENDM Delay      
;-------------------------------------------------------------------------------------
  
            .model small 

            .stack 64 
            .data   

ContinueSTR  db  "Press Enter To Start The Game:$"  
ExitGameStr  db  " -To Exit The Game any time Press ESC$"                                                    
Win          db  "You Win !!$"
Loser        db  "You Lose :($"
DashLine     db  "--------------------------------------------------------------------------------$"           
Right        db  "Right=:0$"     
Wrong        db  "Wrong=:0$"  
Right1       db  "Right$"     
Wrong1       db  "Wrong$" 
Lifesstr     db  "Lifes=:3$"    
dash         db "|$"
Game1        db  " __            __$"
Game2        db  "/ _  ^   /\/\ |__$"
Game3        db  "\__>/-\ /    \|__$"
Over1        db  "         __   _$"
Over2        db  "/\ \  / |__  |_>  $"
Over3        db  "\/  \/  |__  | \ $"
Celbration1  db  "-_-_-_-_-_-_-_-_-_$"
Celbration2  db  "_-_-_-_-_-_-_-_-_-$"
ScoreR       db  0          ;Right answers Score
ScoreL       db  0          ;Wrong answers score              
inCursor     Db      ?      ;X position of the equation
outCursor    Db      00h    ;Y position of the equation
Lifes        db 3      
Num1         db ?           ;The first number
Num2         db ?           ;The second number
Operation    db ?           ;Determine the operation(+-*/)    
 
            .code
main:
    mov ax, @data
    mov ds, ax 
                        
    mov ah,0
    mov al,03h
    int 10h  
      
    ;Draw 1st Window
    mov ah,2
    mov dx,0C12h
    int 10h    
           
    ;2nd string to continue
    mov ah,09h
    mov dx,offset ContinueSTR
    int 21h          
    
    mov ah,2
    mov dx,1700H
    int 10H
            
    mov ah,9
    mov dx,offset Dashline
    int 21H
            
    mov ah,2
    mov dx,1800H
    int 10H
            
    mov ah,9
    mov dx,offset ExitGameStr
    int 21H                      
            
           
    mov ah,0
    int 16h    
    cmp ah,01h
    jz dummy18
    cmp AH,1ch
    jnz main                ;Wait for enter
    
    mov ax,0600h            ;Clear the Screen
    mov bh,07
    mov cx,0
    mov dx,184FH
    int 10h  

;Prepare the scene    
    mov ah,2 
    mov bx,0
    mov dx,1400H
    int 10H    
    
    Mov ah,9  
    mov dx,offset Dashline
    int 21H

    mov ah,2 
    mov bx,0
    mov dx,1500H
    int 10H
            
    Mov ah,9  
    mov dx,offset Right
    int 21H       
    
    mov ah,2 
    mov bx,0
    mov dx,1520H
    int 10H
            
    Mov ah,9
    mov dx,offset Lifesstr
    int 21H   
    
    mov ah,2 
    mov bx,0
    mov dx,1540H
    int 10H
            
    Mov ah,9
    mov dx,offset Wrong
    int 21H             
    
    jmp StartGame

dummy18:jmp escape
    
SMul:                     ;Randomize the numbers for Multplication operation 
    mov Operation,2       
    mov ah, 2ch           ;Get time in Ch,Cl,DH
    int 21h
    mov al,dh
    mov ah,0  
    mov bl,3
    div bl 
    mov num1,ah
     
    mov al,dh       
    mov ah,0  
    mov bl,70
    div bl  
    mov incursor,ah      ; Randomize the position in which the eqation will appeare
    
    mov al,dl
    mov ah,0 
    mov bl,3
    div bl  
    mov num2,ah  
    mov al,ah   
    mov bl,num1
    mul bl
    push ax 
    
    
    mov dh,00h
    mov dl,incursor     
    mov outcursor,0
    mov bh,00h
    mov ah,2
    int 10h  
    jmp Mult 
    
SDiv:                     ;Randomize the numbers for Division operation
    mov Operation,3       
    mov ah, 2ch           ;Get time in Ch,Cl,DH
    int 21h
    mov al,dh
    mov ah,0  
    mov bl,9
    div bl 
    mov num1,ah
     
    mov al,dh       
    mov ah,0  
    mov bl,70
    div bl  
    mov incursor,ah
    
    mov al,dl
    mov ah,0 
    mov bl,9
    div bl  
    mov num2,ah
    mov al,num1  
    mov ah,0   
    mov bl,num2
    div bl  
    mov ah,0
    push ax 
    
    
    mov dh,00h
    mov dl,incursor     
    mov outcursor,0
    mov bh,00h
    mov ah,2
    int 10h  
    jmp Divi   
            
Dummy1:jmp Smul       
dummy13:jmp ssub

StartGame:                ;Randomize wich operation will appear

    mov ah, 2ch           ;Get time in Ch,Cl,DH
    int 21h
    mov al,dh
    mov ah,0  
    mov bl,5
    div bl 
    cmp ah,0
    jz ssum
    cmp ah,1
    jz dummy13
    cmp ah,2
    jz dummy1
    cmp ah,3 
    jz sdiv 
    cmp ah,4
    jz smod
    
SMod:  
    mov Operation,4       
    mov ah, 2ch           ;Get time in Ch,Cl,DH
    int 21h
    mov al,dh
    mov ah,0  
    mov bl,9
    div bl 
    mov num1,ah
     
    mov al,dh       
    mov ah,0  
    mov bl,70
    div bl  
    mov incursor,ah
    
    mov al,dl
    mov ah,0 
    mov bl,9
    div bl  
    mov num2,ah
    mov al,num1  
    mov ah,0   
    mov bl,num2
    div bl    
    mov cx,8
Shift:                   ;to get only the Modulas 
    shr ax,1
    loop shift
    push ax 
    
    
    mov dh,00h
    mov dl,incursor     
    mov outcursor,0
    mov bh,00h
    mov ah,2
    int 10h  
    jmp Modu

SSum:                     ;Randomize the numbers for Sum operation
    mov Operation,0       
    mov ah, 2ch           ;Get time in Ch,Cl,DH
    int 21h
    mov al,dh
    mov ah,0  
    mov bl,4
    div bl 
    mov num1,ah
     
    mov al,dh       
    mov ah,0  
    mov bl,70
    div bl  
    mov incursor,ah
    
    mov al,dl
    mov ah,0 
    mov bl,4
    div bl  
    mov num2,ah     
    mov bl,num1
    add bl,num2 
    push bx 
    
    
    mov dh,00h
    mov dl,incursor     
    mov outcursor,0
    mov bh,00h
    mov ah,2
    int 10h  
    jmp Sum     
    
SSub:                     ;Randomize the numbers for Subtraction operation
    mov Operation,1       
    mov ah, 2ch           ;Get time in Ch,Cl,DH
    int 21h
    mov al,dh
    mov ah,0  
    mov bl,9
    div bl 
    mov num1,ah
     
    mov al,dh       
    mov ah,0  
    mov bl,70
    div bl  
    mov incursor,ah
    
    mov al,dl
    mov ah,0 
    mov bl,9
    div bl  
    mov num2,ah  
    cmp ah,num1
    jg NoNegative   
    mov bl,num1
    sub bl,num2          
    push bx 
    jmp Cont
    
NoNegative:             ;to insure that the result can't be negative number

    mov bl,num2     
    mov ah,num1
    mov num1,bl
    mov num2,ah
    mov bl,num1
    sub bl,num2          
    push bx 
    
Cont:
    
    mov dh,00h
    mov dl,incursor     
    mov outcursor,0
    mov bh,00h
    mov ah,2
    int 10h  
    jmp Subt    
     
    
dummy2:jmp lose             

Sum:                       ; Print the Equation on its position
        mov ax,0600h
        mov bh,07
        mov cx,0
        mov dx,134FH
        int 10h  
        
        inc outcursor        ;Inc Y component to make the equation move down
        cmp outcursor,14h  
        jz dummy2
        mov dh,outcursor
        mov dl,incursor  
        mov ah,2
        mov bh,00h  
        int 10h  
        
         
        mov dl,num1
        add dl,'0'
        mov ah,2
        int 21h         
        mov dl,'+'
        mov ah,2
        int 21h   
        mov dl,num2
        add dl,'0'
        mov ah,2
        int 21h     
        mov dl,'='
        mov ah,2
        int 21h  
        mov dl,'?'
        mov ah,2
        int 21h       
        
        mov ah,1        ;Check if key pressed
        int 16h
        jnz dummy3          
        
        delay                
        jmp sum        
        
dummy3:jmp check 
dummy4:jmp lose   

    
Subt:        
        mov ax,0600h
        mov bh,07
        mov cx,0
        mov dx,134FH
        int 10h  
        
        inc outcursor   
        cmp outcursor,14h  
        jz dummy4
        mov dh,outcursor
        mov dl,incursor  
        mov ah,2
        mov bh,00h  
        int 10h     
                
         
        mov dl,num1
        add dl,'0'
        mov ah,2
        int 21h         
        mov dl,'-'
        mov ah,2
        int 21h   
        mov dl,num2
        add dl,'0'
        mov ah,2
        int 21h     
        mov dl,'='
        mov ah,2
        int 21h  
        mov dl,'?'
        mov ah,2
        int 21h
                
          
        mov ah,1
        int 16h
        jnz dummy12
        delay   
        jmp subt    
        
dummy5:jmp lose 
dummy12:jmp check       
        
Mult:        
        mov ax,0600h
        mov bh,07
        mov cx,0
        mov dx,134FH
        int 10h  
        
        inc outcursor   
        cmp outcursor,14h  
        jz dummy5
        mov dh,outcursor
        mov dl,incursor  
        mov ah,2
        mov bh,00h  
        int 10h  
        
         
        mov dl,num1
        add dl,'0'
        mov ah,2
        int 21h         
        mov dl,'X'
        mov ah,2
        int 21h   
        mov dl,num2
        add dl,'0'
        mov ah,2
        int 21h     
        mov dl,'='
        mov ah,2
        int 21h  
        mov dl,'?'
        mov ah,2
        int 21h     
        mov ah,1
        int 16h
        jnz dummy6 
        delay   
        jmp Mult    
        
dummy6: jmp check    
dummy14: jmp lose
        
Divi:        
        mov ax,0600h
        mov bh,07
        mov cx,0
        mov dx,134FH
        int 10h  
        
        inc outcursor   
        cmp outcursor,14h  
        jz dummy14
        mov dh,outcursor
        mov dl,incursor  
        mov ah,2
        mov bh,00h  
        int 10h  
        
         
        mov dl,num1
        add dl,'0'
        mov ah,2
        int 21h         
        mov dl,'/'
        mov ah,2
        int 21h   
        mov dl,num2
        add dl,'0'
        mov ah,2
        int 21h     
        mov dl,'='
        mov ah,2
        int 21h  
        mov dl,'?'
        mov ah,2
        int 21h     
        mov ah,1
        int 16h
        jnz dummy15 
        delay   
        jmp Divi 
        
dummy15:jmp check        
        
Modu:        
        mov ax,0600h
        mov bh,07
        mov cx,0
        mov dx,134FH
        int 10h  
        
        inc outcursor   
        cmp outcursor,14h  
        jz lose
        mov dh,outcursor
        mov dl,incursor  
        mov ah,2
        mov bh,00h  
        int 10h  
        
         
        mov dl,num1
        add dl,'0'
        mov ah,2
        int 21h         
        mov dl,'%'
        mov ah,2
        int 21h   
        mov dl,num2
        add dl,'0'
        mov ah,2
        int 21h     
        mov dl,'='
        mov ah,2
        int 21h  
        mov dl,'?'
        mov ah,2
        int 21h     
        mov ah,1
        int 16h
        jnz check 
        delay   
        jmp Modu         
lose1:
        mov scorel,0    
        mov ah,2 
        mov bx,0
        mov dh,15h
        mov dl,47h
        int 10h
        mov dl,ScoreL
        add dl,'0'
        mov ah,2
        int 21h                             
        
Lose:                    ;When the equation hits the bottom dec. Lifes and check if it beacame Zero
        dec lifes    
        mov ah,2 
        mov bx,0
        mov dh,15h
        mov dl,27h
        int 10h
        mov dl,lifes
        add dl,'0'
        mov ah,2
        int 21h   
        cmp lifes,0
        jz GO
        jmp startgame        
        
GO:
         call GameOver          ; Call Game Over Proc.   
         jmp main        
         
         
dummy17: jmp Escape                                   
        
check:                        ; Check If the key pressed is the write answer or not  
        cmp ah,01h
        jz dummy17
        pop bx
        mov ah,0
        int 16h
        sub al,'0'
        cmp al,bl 
        push bx  
        jz True
false:                       ; ifit is wrong answer Inc Wrong score and print it to the screen 
            
        inc ScoreL   
        cmp scorel,5         ; if 5 Answers was wrong dec lifes and start again
        jz lose1
        mov ah,2 
        mov bx,0
        mov dh,15h
        mov dl,47h
        int 10h
        mov dl,ScoreL
        add dl,'0'
        mov ah,2
        int 21h
        cmp operation,0        ;to know wich operation i am in
        jz dummy7       
        cmp operation,1
        jz dummy8
        cmp operation,2
        jz dummy9
        cmp operation,3
        jz dummy10 
        cmp operation,4
        jz dummy16
 
true:                          ; ifit is Right answer Inc right score and print it to the screen 
        inc ScoreR
        cmp scorer,5          ; if 5 Answers was right U win
        jz go 
        mov ah,2 
        mov bx,0
        mov dh,15h
        mov dl,07h
        int 10h
        mov dl,ScoreR
        add dl,'0'
        mov ah,2
        int 21h   
        
        jmp startgame      
        
dummy7: jmp sum
dummy8: jmp subt
dummy9: jmp Mult
dummy10: jmp divi 
dummy16: jmp modu         


       
Escape:                        ; to end the program
            mov ah, 4ch
            int 21h
            HLT  
            
;----------------------------------------------------------------------------------------------------            
GameOver  Proc                   ;Display The Scores Window after the game
            mov ah,0
            mov al,13H
            int 10H
            int 10H
;Write a big Game Over Word            
            mov ah,2
            mov dx,060AH
            int 10H
            
            Mov ah,9
            mov dx,offset Game1
            int 21H
            
            mov ah,2
            mov dx,070AH
            int 10H
            
            Mov ah,9
            mov dx,offset Game2
            int 21H
            
            mov ah,2
            mov dx,080AH
            int 10H
            
            Mov ah,9
            mov dx,offset Game3
            int 21H
            
            mov ah,2
            mov dx,0C0AH
            int 10H
            
            Mov ah,9
            mov dx,offset Over1
            int 21H
            
            mov ah,2
            mov dx,0D0AH
            int 10H
            
            Mov ah,9
            mov dx,offset Over2
            int 21H
            
            mov ah,2
            mov dx,0E0AH
            int 10H
            
            Mov ah,9
            mov dx,offset Over3
            int 21H
            
            Mov ah,2
            mov dx,120cH
            int 10H  
;Compare Score1 And Score2 to know the winner            
            mov ah,ScoreR
            cmp ah,ScoreL            
            jle  Player2Won
            Mov ah,9
            mov dx,offset Win
            int 21H 
            jmp winn  
            
            
Player2Won: 
            Mov ah,9
            mov dx,offset Loser
            int 21H
            
winn:    
            
            
            mov ah,2
            mov dx,1420H
            int 10H
;print Right and wrong           
            mov ah,9
            mov dx,offset Wrong1
            int 21H
            
            mov ah,2
            mov dx,1401H
            int 10H
            
            mov ah,9
            mov dx,offset Right1
            int 21H
            
            mov bx,5
            
Celebrate:                    ;print the Scores of Right and wrong and draw a dancing line XD
            mov ah,2
            mov dx,140Ah
            int 10H
            
            mov ah,9
            mov dx,offset Celbration1
            int 21H
            
            MOV CX, 08H       ;wait 0.5 second
            MOV DX, 2155H
            MOV AH, 86H
            INT 15H
            
            mov ah,2
            mov dx,140Ah
            int 10H
            
            mov ah,9
            mov dx,offset Celbration2
            int 21H
            
            MOV CX, 07H       ;wait 0.5 second
            MOV DX, 2155H
            MOV AH, 86H
            INT 15H 
;Display the score            
            cmp bx,5
            jg hena1
            mov ah,2
            mov dx,1303H
            int 10H
            mov ah,9
            mov dx,offset dash
            int 21H
            mov ah,2
            mov dx,1322H
            int 10H
            mov ah,9
            mov dx,offset dash
            int 21H
            cmp bx,4
            jg hena1
            mov ah,2
            mov dx,1203H
            int 10H
            mov ah,9
            mov dx,offset dash
            int 21H
            mov ah,2
            mov dx,1222H
            int 10H
            mov ah,9
            mov dx,offset dash
            int 21H
            cmp bx,3
            jg lol
            mov ah,2
            mov dx,1103H
            int 10H
            mov ah,9
            mov dx,offset dash
            int 21H
            mov ah,2
            mov dx,1122H
            int 10H
            mov ah,9
            mov dx,offset dash
            int 21H 
            cmp bx,2
hena1:      jg lol
            mov ah,2
            mov dx,1003H
            int 10H
            mov dl,ScoreR
            mov dh,0
            add dl,'0'
            int 21H
            mov dx,1022H
            int 10H
            mov dl,ScoreL
            add dl,'0'
            int 21H           
lol:            
            dec bx
            cmp bx,0
            jnz jumper 
            ret
jumper:     jmp Celebrate
            ret                  
            
   GameOver         EndP

;------------------------                 
   
      end main
