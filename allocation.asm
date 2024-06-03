;Выделить динамическую память с помощью int 21h, заполнить поля
;структуры.
;Аргументы:
;ds:dx – сегмент и смещение до структуры
;cx – количество выделяемых байт
;Результат:
;ax – результат выполнения функции

.model small

public alloc_mem

.stack 100h

include BASE_STR.inc

.code
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