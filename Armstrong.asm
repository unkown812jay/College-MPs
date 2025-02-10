;Assembly code for armstrong number
data segment
str db 'Enter a number:$'
msg1 db 0dh, 0ah, 'Number is armstrong', 0dh, 0ah, '$'
msg2 db 0dh, 0ah, 'Number is not armstrong', 0dh, 0ah, '$'
num dw ?
ten db 10
q db ?
rem db ?
data ends

code segment
assume cs: code, ds: data, es: data
start:  mov ax, data
        mov ds, ax
        mov es, ax
        mov ah, 09h
        mov dx, offset str
        int 21h
        mov dx, num
        mov ah, 0ah
        int 21h
        mov ax, num
        mov bx, 0
        do:     cmp al,0
                je done
                div ten         ; al->quotient, ah->remainder
                mov rem, ah
                mov ah, 0
                mov q, al
                mov al, rem
                mul rem
                mul rem
                add bx, ax      ; bx -> bx + (last_digit)^3
                mov ax, 0
                mov al, q
                loop do
        done:   cmp num, bx
                jne not_armstrong
                lea dx, msg1
                mov ah, 09
                int 21h
        not_armstrong:  lea dx, msg2
                        mov ah, 09
                        int 21h
        mov ah, 4ch
        int 21h
        code ends
end start
