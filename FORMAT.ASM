.model small
.stack 100h
.386

public format

extrn EXIT_SUCCESS: abs
extrn INDEX_OUT_OF_RANGE: abs

; Аргументы:
; ds:dx – сегмент и смещение до структуры
; bx – вариант форматного вывода 
; 1 – выводит каждый байт в шестнадцатеричном формате.
; 2 – выводит каждый байт в двоичном формате.
; 3 – выводит байты как ASCII символы
; 4 – вывод ASCII код символа

.code

format proc uses dx
    mov si, dx
    mov ax, bx
    xor cx, cx
    mov bx, [si + 2]
    mov es, bx

    cmp ax, 1
    je first
    cmp ax, 2
    je second
    cmp ax, 3
    je third
    cmp ax, 4
    je fourth

    the_end:
        ret   

; 1 – выводит каждый байт в шестнадцатеричном формате.
first: 
    b1:
        mov ah, 02h
        mov bx, cx
        
        mov  al, es:[bx]      
        cbw               
        mov  dl, 16
        div  dl           
        add  ax, "00"
        mov  dx, ax
        mov  ah, 02h
        int  21h
        mov  dl, dh
        int  21h

        mov dl, " "
        int 21h

        inc cx
    cmp [si], cx
    ja b1
    jmp the_end

; 2 – выводит каждый байт в двоичном формате.
second: 
    b2:
        mov bx, cx
        mov dl, es:[bx]

        mov bh, 8
        mov bl, dl
        print_loop:
            xor dl, dl
            shl bl, 1
            adc dl, "0"
            mov ah, 02h
            int 21h  

            dec bh
            cmp bh, 0
            jne print_loop 

        mov dl, " "
        int 21h

        inc cx
    cmp [si], cx
    ja b2
    jmp the_end

; 3 – выводит байты как ASCII символы
third: 
    b3:
        mov ah, 02h
        mov bx, cx
        mov dl, es:[bx]
        int 21h

        mov dl, " "
        int 21h

        inc cx
    cmp [si], cx
    ja b3
    jmp the_end

; 4 – вывод ASCII код (значения байта)
fourth: 
    b4:
        mov ah, 02h
        mov bx, cx
        
        mov  al, es:[bx]      
        cbw               
        mov  dl, 10
        div  dl           
        add  ax, "00"
        mov  dx, ax
        mov  ah, 02h
        int  21h
        mov  dl, dh
        int  21h

        mov dl, " "
        int 21h

        inc cx
    cmp [si], cx
    jae b4
    jmp the_end

format endp

end
