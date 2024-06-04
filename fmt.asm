.model small
.386

public format

include BASE_STR.inc


.code
;/**
; * @brief Вывести содержимое структуры в различных форматах
; * 
; * @param ds:dx Сегмент и смещение до структуры
; * @param bx Вариант форматного вывода:
; *         - 1: вывод каждого байта в шестнадцатеричном формате
; *         - 2: вывод каждого байта в двоичном формате
; *         - 3: вывод байтов как ASCII символы
; *         - 4: вывод ASCII кода символа
; * @author Асадуллин Тагир ИУ7-44Б
; */

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
;/**
; * @param bx Вариант форматного вывода:
; *         - 1: вывод каждого байта в шестнадцатеричном формате
; */
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

;/**
; * @param bx Вариант форматного вывода:
; *         - 2: вывод каждого байта в двоичном формате
; */
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

;/**
; * @param bx Вариант форматного вывода:
; *         - 3: вывод байтов как ASCII символы
; */
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

;/**
; * @param bx Вариант форматного вывода:
; *         - 4: вывод ASCII кода символа
; */
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
