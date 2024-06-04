;/**
; * @brief Код успешного завершения
; */
EXIT_SUCCESS equ 0

;/**
; * @brief Код ошибки выделения памяти
; */
ALLOCATION_ERROR equ 10

;/**
; * @brief Код ошибки выхода за пределы индекса
; */
INDEX_OUT_OF_RANGE equ 30

;/**
; * @brief Код ошибки освобождения памяти
; */
FREE_ERROR equ 20

;/**
; * @brief Структура для динамического массива
; *
; * Структура, содержащая длину и массив данных
; * 
; * @param len Длина вектора
; * @param arr Массив данных
; */
vector struc
    len dw 1 dup(?)
    arr dw 1 dup(?)
vector ends