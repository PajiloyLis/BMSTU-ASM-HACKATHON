.model small
.stack 100h

include BASE_STR.inc

.data
newline db 13, 10, '$'
length_str db 'Длина: $'
array_str db 'Массив: $'
space db ' $'
vector1 vector <>

print_vector proc


print_vector endp


.code
extern alloc_mem: proc
extern set: proc
extern get: proc
extern free_mem: proc

main proc
    ; Установим сегментные регистры
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Выделим память под структуру vector
    lea dx, vector1
    mov cx, 15
    call alloc_mem
    cmp ax, EXIT_SUCCESS
    jne alloc_fail

    ; Заполним массив псевдослучайными числами
    lea dx, vector1
    mov cx, 10         ; 
    mov di, 0          ; 

fill_loop:
    ; Генерация псевдослучайного числа
    mov ah, 2Ch
    int 21h
    mov bl, dl          ; Сохраняем случайное число в bl

    ; Устанавливаем значение в массиве
    push cx             ; Сохраняем cx
    push dx             ; Сохраняем dx
    mov cx, di          
    call set
    pop dx              ; Восстанавливаем dx
    pop cx              ; Восстанавливаем cx

    cmp ax, EXIT_SUCCESS
    jne set_fail

    inc di              ; Переходим к следующему индексу
    cmp di, 10          ; Проверяем, заполнили ли весь массив
    jl fill_loop

    ; Печатаем массив
    

    ; Завершение программы
    call free_mem
    mov ax, 4C00h
    int 21h

alloc_fail:
    ; Обработка ошибки выделения памяти
    mov ax, 4C01h
    int 21h

set_fail:
    ; Обработка ошибки установки значения
    mov ax, 4C02h
    int 21h

main endp

end main