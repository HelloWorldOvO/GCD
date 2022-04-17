;GCD Program               (gcd.asm)

; input x and y, calculate the gcd


INCLUDE Irvine32.inc


.data
message1  BYTE  "Enter the first interger : ",0
message2  BYTE  "Enter the second interger: ",0
message3  BYTE  "The gcd is ",0
message4  BYTE  "type 1 to repeat, type any other key to end:",0

X DWORD ?
Y DWORD ?

.code
main PROC



L1:
    call input
    call GCD

    call crlf
    mov edx, OFFSET message4
    call WriteString
    call ReadInt
    
    cmp eax, 1
    je L1

    exit
main ENDP


;-----------------------------------------------------
GCD PROC
;
; calculate the gcd
; Receives: X , Y
; Returns: gcd
;-----------------------------------------------------
    pushad              ; store all register
    ;-------------------------------------------------
    
Euclidean_algorithm:
    mov eax, X
    mov ebx, Y
    cdq                 ; sign-extension
    idiv ebx

    mov eax,Y           ; eax = divisor 

    mov X,edx           ; X = remainder

    cmp edx, 0          ; if (remainder = 0)
    je FIND_GCD

    mov eax, Y
    mov ebx, X
    cdq                 ; sign-extension
    idiv ebx

    mov eax,X           ; eax = divisor

    mov Y,edx           ; Y = remainder

    cmp edx, 0          ; if (remainder = 0)
    je FIND_GCD
    
    JMP Euclidean_algorithm

FIND_GCD:
    mov edx, OFFSET message3
    call WriteString

    call WriteDec
    
    ;-------------------------------------------------
    popad               ; restore all register
    ret
GCD ENDP


;-----------------------------------------------------
input PROC uses edx eax
;
; input two interger to X and Y
;-----------------------------------------------------
    mov eax, 0
    
    ;show the message1
    mov edx, OFFSET message1
    call WriteString

    ;input a interger to X
    call ReadInt
    mov X, eax

    ;show the message2
    mov edx, OFFSET message2
    call WriteString

    ;input a interger to Y
    call ReadInt
    mov Y, eax

    ret
input ENDP


END main