.model small

public get

include BASE_STR.inc

.code
; Получить значение байта из массива (Часть 1)
; Аргументы:
; ds:dx – сегмент и смещение до структуры
; cx – позиция байта
; Результат:
; bl – значение байта
; ax – результат выполнения функции:
;    0 - успех
;    1 - ошибка: позиция вне диапазона
get proc uses dx
  ; check cx < len(arr)
    mov si, dx
    mov ax, [si]
    cmp cx, ax
    jae err_exit
  ; bl = arr[cx]
    mov ax, [si + 2]

    mov es, ax

    mov al, bl
    mov bx, cx
    mov bl, es:[bx]
  success_exit:
    mov ax, EXIT_SUCCESS
    jmp exit
  err_exit:
    mov ax, INDEX_OUT_OF_RANGE
  exit:
    ret
get endp
end