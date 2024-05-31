.model small

.stack 100h

.data
; тестовая структура
Struct struct
	length dw 256
    array db 256 dup(?)
Struct ends
pointer_struct Struct <>

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
get proc
	; check cx < len(arr)
    mov si, dx
	mov ax, [si]
	cmp cx, ax
	jae err_exit
	; bl = arr[cx]
	add si, cx
	mov bl, [si]
	success_exit:
		xor ax, ax
		jmp exit
	err_exit:
		mov ax, 1
	exit:
		ret
get endp

main:
	mov ax, @data
    mov ds, ax
    mov dx, offset pointer_struct
    ; cx = 5 (пример)
    mov cx, 5
    ; Вызов функции получения значения байта из массива
    call get
    ; Обработка результата (ax = 0 - успех, 1 - ошибка)
	; в разработке
    mov ah, 4C00h
    int 21h
end main