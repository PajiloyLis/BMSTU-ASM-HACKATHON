.model small

include BASE_STR.inc

public format

extrn get: near

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
format proc uses ax cx di si dx
    pushf
    mov di, dx
    mov si, [di]
    xor cx, cx
    
    cmp bx, 1
    je first
    cmp bx, 2
    je second
    cmp bx, 3
    je third
    cmp bx, 4
    je fourth
    
    the_end:
        popf
        ret   

;/**
; * @brief ; bx - 1 – выводит каждый байт в шестнадцатеричном формате.
; */
first: 
    b1:
        mov ah, 02h
        mov bx, cx
        mov dx, di
        call get
        mov al, bl
        cbw      
        mov  dl, 16
        div  dl   
        add  ax, "00"
        mov  dx, ax
        mov  ah, 02h
        int  21h
        mov  dl, dh
        mov ah, 02h
        int  21h
        mov dl, " "
        mov ah, 02h
        int 21h
        
        inc cx
        cmp si, cx
        ja b1
    jmp the_end

;/**
; * @brief ; bx - 2 выводит каждый байт в двоичном формате.
; */

second: 
    b2:
        mov bx, cx
        mov dx, di
        call get
        mov dl, bl

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
        cmp si, cx
        ja b2
    jmp the_end

;/**
; * @brief ; bx - 3 – выводит байты как ASCII символы
; */
third: 
    b3:
        mov dx, di
        call get
        mov dl, bl
        mov ah, 02h
        int 21h
        mov dl, " "
        mov ah, 02h
        int 21h
        inc cx
        cmp si, cx
        ja b3
    jmp the_end

;/**
; * @brief ; bx - 4 – вывод ASCII код (значения байта)
; */
fourth: 
    b4:
        mov ah, 02h
        mov bx, cx
        
        mov dx, di
        call get
        mov al, bl  

        cbw               
        mov  dl, 10
        div  dl           
        add  ax, "00"
        mov  dx, ax
        mov  ah, 02h

        int  21h
        mov  dl, dh
        mov ah, 02h
        int  21h

        mov dl, " "
        mov ah, 02h
        int 21h

        inc cx
        cmp si, cx
        ja b4
    jmp the_end

format endp

end