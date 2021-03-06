; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
;Memory Allocation
; data 1 - 0x8000:1000 to 0x8000:100F
; data 2 - 0x8000:1008 to 0x8010:1020
; RESULT - 0X8000:1020

;Result interpretation
; if data 1 > data 2 then RESULT IS 1
; if data 1 < data 2 then RESULT IS 2
; if data 1 = data 2 then RESULT IS 0
; add your code here    
    MOV AX,0X8000
    MOV DS,AX
    MOV SI,0X1000 
    MOV CX,0XE
    ADD SI,CX          ; comparison starts from most significant word
    MOV CX,0X8         ; loop runs 8 times
    
    
LOOP1:
    MOV AX,[SI]
    MOV BX,[SI+0X10]
    DEC SI
    DEC SI
    CMP AX,BX
    JZ CONTINUE        ; if equal run the loop again
    JNC ANSWER1        ; if AX>BX then result is 1
    JC ANSWER2         ; if AX<BX then result is 2
    
    
CONTINUE:
    LOOP LOOP1
    
    
    MOV SI,0X1020      ;data 1 = data 2, result = 0
    MOV [SI],0X00
    RET
    
    
ANSWER1:
    MOV SI,0X1020
    MOV [SI],0X01
    RET
    
    
ANSWER2:
    MOV SI,0X1020
    MOV [SI],0X02
    RET
ret
