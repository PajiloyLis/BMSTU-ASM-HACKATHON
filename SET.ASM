.model small
.stack 100h

public set

include BASE_STR.inc

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

    mov si, ax

    mov al, bl
    mov bx, cx
    mov [si+bx], al

    ok:
        mov ax, EXIT_SUCCESS
        jmp exit

    bad:
        mov ax, INDEX_OUT_OF_RANGE
        ret

    exit:
        ret   
set endp
end