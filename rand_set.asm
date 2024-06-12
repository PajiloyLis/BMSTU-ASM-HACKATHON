.model small
.stack 100h

include BASE_STR.inc

.data
vector1 vector <>

.code

; Экспортируемые процедуры
extern set: proc
extern get: proc

;**
; * @brief Заполнить массив псевдослучайными числами
; * 
; * @param ds:dx сегмент и смещение до структуры
; * @param ax Результат выполнения функции: EXIT_SUCCESS - успех
; * @return заполненный массив
; */
main proc
    ; Установим сегментные регистры
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; заполнение
    lea dx, vector1
    mov si, dx        ; si указывает на начало структуры
    mov ax, [si]      ; получить длину массива в ax
    mov cx, ax        ; сохранить длину массива в cx
    mov di, 0         ; индекс массива

fill_loop:
    ; Генерация псевдослучайного числа
    mov ah, 2Ch
    int 21h
    mov bl, dl        

    ; установка значения
    push cx           
    push dx          
    mov cx, di       
    call set
    pop dx            
    pop cx            

    cmp ax, EXIT_SUCCESS
    jne set_fail

    inc di            ; Переходим к следующему индексу
    cmp di, cx        ; Проверяем, заполнен ли весь массив
    jl fill_loop

    ; Завершение программы
    lea dx, vector1
    mov ax, 4C00h
    int 21h

set_fail:
    ; Обработка ошибки установки значения
    mov ax, 4C02h
    int 21h

main endp

end main
