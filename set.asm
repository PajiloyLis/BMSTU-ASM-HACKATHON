.model small

public set

include BASE_STR.inc


.code
;/**
; * @brief Получить значение байта из массива
; * 
; * @param ds:dx Сегмент и смещение до структуры
; * @param cx Позиция байта
; * @param bl Значение байта
; * @return ax Результат выполнения функции
; * @author Асадуллин Тагир ИУ7-44Б
; */
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