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
    mov cx, [si]
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
    a:
        mov ah, 02h
        to_hex_digit:
            add dl,'0'              
            cmp dl,'9'  
        int 21h           
        jle fin             
        add dl,7     
        int 21h          
    fin:
        add dl, " "    
        int 21h   
        loop a
    jmp the_end

second: 
    b2:
        mov ah, 02h
        mov dl, "y"
        int 21h
    loop b2
    jmp the_end

third: 
    run:
        mov ah, 02h
        mov dl, "x"
        int 21h
    loop run
    jmp the_end

fourth: 
    d:
        mov ah, 02h
        mov dl, "z"
        int 21h
    loop d

    jmp the_end

format endp
end