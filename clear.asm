.model small

public free_mem

include BASE_STR.inc

;/**
; * @brief Занулить и освободить выделенную память, а также занулить поля структуры
; * 
; * @param ds:dx Сегмент и смещение до структуры
; * @return ax Результат выполнения функции
; * @retval EXIT_SUCCESS Успешное выполнение
; * @retval FREE_ERROR Ошибка при освобождении памяти
; * @author Парфенов Арсений ИУ7-44Б
; */
.code
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

    epic_success:
    mov ax, EXIT_SUCCESS
    ret

    epic_fail:
    mov ax, FREE_ERROR
    ret

free_mem endp
end