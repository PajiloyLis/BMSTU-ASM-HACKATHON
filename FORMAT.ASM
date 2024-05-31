.model small
.stack 100h

public set

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
first proc 
    mov cx,
    a:

    ret
first endp

second proc 

    ret
second endp

third proc 

    ret
third endp

fourth proc 

    ret
fourth endp

format proc uses dx
    mov si, dx
    cmp bx, 1
    je first
    cmp bx, 2
    je second
    cmp bx, 3
    je third
    cmp bx, 4
    je fourth
    ret   
set endp