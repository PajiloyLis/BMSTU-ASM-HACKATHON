.model small

public get

include BASE_STR.inc

.code
;/**
; * @brief Получить значение байта из массива
; * 
; * @param ds:dx Сегмент и смещение до структуры
; * @param cx Позиция байта
; * @return bl Значение байта
; * @return ax Результат выполнения функции: EXIT_SUCCESS - успех, INDEX_OUT_OF_RANGE - ошибка: позиция вне диапазона
; * @author Талышева Олеся ИУ7-45Б
; */
get proc uses dx si
    mov si, dx
    mov ax, [si]
    cmp cx, ax
    jae err_exit
    mov ax, [si + 2]

    mov si, ax

    mov bx, cx
    mov bl, [si+bx]
  success_exit:
    mov ax, EXIT_SUCCESS
    jmp exit
  err_exit:
    mov ax, INDEX_OUT_OF_RANGE
  exit:
    ret
get endp
end