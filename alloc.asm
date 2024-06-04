.model small

public alloc_mem

include BASE_STR.inc

.code
;/**
; * @brief Выделить динамическую память с помощью int 21h и заполнить поля структуры
; * 
; * @param ds:dx Сегмент и смещение до структуры
; * @param cx Количество выделяемых байт
; * @return ax Результат выполнения функции
; * @author Парфенов Арсений ИУ7-44Б
; */
alloc_mem proc uses dx bx cx si di

    mov bx, dx
    xor dx, dx
    mov ax, cx

    mov si, cx

    mov cx, 10h
    div cx
    
    test dx, dx
    jz skip
    inc ax
    skip:
    mov di, bx
    mov bx, ax
    
    mov ah, 48h
    int 21h
    jc epic_fail
    
    mov ds:[di], si
    mov ds:[di + 2h], ax

    epic_success:
        mov ax, EXIT_SUCCESS
        ret

    epic_fail:
        mov ax, ALLOCATION_ERROR
        ret
    
alloc_mem endp
END