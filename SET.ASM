.model small
.stack 100h

public set

extrn EXIT_SUCCESS: abs
extrn INDEX_OUT_OF_RANGE: abs

; Аргументы:
; ds:dx – сегмент и смещение до структуры
; cx – позиция байта
; bl – значение байта
; Результат:
; ax – результат выполнения функции 
.code
set proc uses dx
    
    mov si, dx
    mov ax, [si]
    cmp cx, ax
    jae bad

    mov ax, [si + 2]

    mov es, ax

    mov al, bl
    mov bx, cx
    mov es:[bx], al

    ok:
        mov ax, EXIT_SUCCESS
        jmp exit

    bad:
        mov ax, INDEX_OUT_OF_RANGE
        ret

    exit:
        ret   
set endp
