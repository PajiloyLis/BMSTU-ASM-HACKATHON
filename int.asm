;/**
; * @file
; * @brief Модуль для установки и удаления перехвата прерывания 21h и записи данных (значения dl) в буфер (buff) по вызову функции ah=02h 
; * @author Парфенов Арсений ИУ7-44Б
; */

public buff
public install
public del

.286
.model small
.stack 100h

.data 
    buff db 100 dup(0), "$"

.code
    org 100h
    old21   label dword 
    old21ip dw 0
    old21cs dw 0
    str2 db "Hi$"
    cur dw 0


;/**
; * @brief Обработчик перехваченного прерывания 21h по функции ah=02h
; */
New21:
        pusha
        pushf
        push ds
        push es

        push ax

        mov al, 02h

        cmp ah, al
        pop ax
        jne old

        mov bx, [cur]
        mov [buff][bx], dl
        inc bx
        mov [cur], bx

        jmp end2

    old:
        pop es
        pop ds
        popf
        popa

        pushf
        call cs:old21
    
        iret

    end2:
        pop es
        pop ds
        popf
        popa
        iret


;/**
; * @brief Процедура для установки перехвата
; */
install proc
       push ds

       push cs
       pop  ds

       mov cx, [cur]
       test cx, cx
       jz skip_cycle

       xor bx, bx

       cycle:
            mov buff[bx], 0h
            inc bx
            loop cycle
       mov [cur], 0h

       skip_cycle:

       mov      ax,3521h
       int      21h
       mov      word ptr old21ip, bx
       mov      word ptr old21cs, es

       mov      ax,2521h
       mov      dx,offset New21
       int      21h

       pop ds
       retf
install endp

;/**
; * @brief Процедура для удаления перехвата
; */
del proc
       push ds
       lds      dx, old21 
       mov      ax, 2521h
       int      21h
       pop ds
       retf
del endp

end
