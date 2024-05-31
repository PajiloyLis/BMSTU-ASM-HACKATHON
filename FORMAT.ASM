.model small
.stack 100h

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

first: 
    b1:
        mov ah, 02h
        mov bx, cx
        mov dl, es:[bx]
        mov al, dl

        int 21h
        inc cx
    cmp [si], cx
    ja b1
    jmp the_end

second: 
    b2:
        mov ah, 02h
        mov bx, cx
        mov dl, es:[bx]
        mov al, dl
        
        int 21h
        inc cx
    cmp [si], cx
    ja b2
    jmp the_end

third: 
    b3:
        mov ah, 02h
        mov bx, cx
        mov dl, es:[bx]
        int 21h
        inc cx
    cmp [si], cx
    ja b3
    jmp the_end

fourth: 
    b4:
        mov ah, 02h
        mov bx, cx
        mov dl, es:[bx]
        int 21h
        inc cx
    cmp [si], cx
    ja b4
    jmp the_end
format endp

end
