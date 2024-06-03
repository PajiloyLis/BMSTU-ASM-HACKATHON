.model small
.code

public free_mem

include BASE_STR.inc

; Занулить и освободить выделенную память, а также занулить поля структуры
; Аргументы:
; ds:dx – сегмент и смещение до структуры
; Результат:
; ax – результат выполнения функции
; ok 0
; err 2
free_mem proc uses dx bx es cx
    mov bx, dx
    mov cx, ds:[bx]; длина

    xor ax, ax

    mov ds:[bx], ax
    mov ax, ds:[bx + 2]
    mov si, ax ; es:0000 - начало массива
    mov es, ax
    xor bx, bx
    xor ax, ax

    cycle:
        mov [si+bx], ax
        inc bx
        loop cycle
    
    mov ah, 49h
    int 21h

    jc epic_fail

    epic_fail:
    mov ax, FREE_ERROR
    ret

    epic_success:
    mov ax, EXIT_SUCCESS
    ret

free_mem endp
end