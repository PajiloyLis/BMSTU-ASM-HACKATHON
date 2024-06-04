;/**
; * @file
; * @brief Модуль для тестирования функции format
; * @author Асадуллин Тагир ИУ7-44Б
; */

.model small
.stack 100h
.286

include BASE_STR.inc

public test_format_feature

extrn format: near
extrn buff: byte
extrn install: far
extrn del: far
extrn free_mem: near
extrn alloc_mem: near
extrn get: near
extrn set: near
extrn introduction_print: near
extrn value_error_print: near
extrn return_code_error_print: near
extrn allocation_error_print: near
extrn error_print: near
extrn success_print: near


test_size = 5

.data

    expected_output_ascii db "A B C D E ", 0, '$'
    expected_output_ascii_code db "65 66 67 68 69 ", 0, '$'
    expected_output_hex db "41 42 43 44 45 ", 0, '$'
    expected_output_bin db "01000001 01000010 01000011 01000100 01000101 ", 0, '$'
    
    test_1 vector <>

.code
ascii_print proc near uses ax bx cx dx si 
    pushf
    mov ax, @data
    mov ds, ax
    xor cx, cx
    mov cl, '1'
    call introduction_print

    call allocate_memory
    cmp ax, EXIT_SUCCESS
    jne alloc_error

    call fill_memory

    call install
    mov dx, offset test_1
    mov bx, 3
    call format
    call del

    lea si, expected_output_ascii
    call perform_test
    mov dx, offset test_1
    call free_mem

    popf
    ret
alloc_error:
    call allocation_error_print
    popf
    ret

ascii_print endp

ascii_code_print proc near uses ax bx cx dx si 
    pushf
    mov ax, @data
    mov ds, ax
    xor cx, cx
    mov cl, '2'
    call introduction_print

    call allocate_memory
    cmp ax, EXIT_SUCCESS
    jne alloc_error

    call fill_memory

    call install
    mov dx, offset test_1
    mov bx, 4
    call format
    call del

    lea si, expected_output_ascii_code
    call perform_test 

    mov dx, offset test_1
    call free_mem
    popf
    ret
alloc_error:
    call allocation_error_print
    popf
    ret
ascii_code_print endp

hex_print proc near uses ax bx cx dx si 
    pushf
    mov ax, @data
    mov ds, ax
    xor cx, cx
    mov cl, '3'
    call introduction_print

    call allocate_memory
    cmp ax, EXIT_SUCCESS
    jne alloc_error

    call fill_memory

    call install
    mov dx, offset test_1
    mov bx, 1
    call format
    call del

    lea si, expected_output_hex
    call perform_test 

    popf
    ret
alloc_error:
    call allocation_error_print
    popf
    ret
hex_print endp

bin_print proc near uses ax bx cx dx si 
    pushf
    mov ax, @data
    mov ds, ax
    xor cx, cx
    mov cl, '4'
    call introduction_print

    call allocate_memory
    cmp ax, EXIT_SUCCESS
    jne alloc_error

    call fill_memory

    call install
    mov dx, offset test_1
    mov bx, 2
    call format
    call del

    lea si, expected_output_bin
    call perform_test 

    mov dx, offset test_1
    call free_mem
    popf
    ret
alloc_error:
    call allocation_error_print
    popf
    ret
bin_print endp

bad_code proc near uses ax bx cx dx si 
    pushf
    mov ax, @data
    mov ds, ax
    xor cx, cx
    mov cl, '5'
    call introduction_print

    call allocate_memory
    cmp ax, EXIT_SUCCESS
    jne alloc_error

    call fill_memory

    mov dx, offset test_1
    mov bx, 8
    call format

    mov dx, offset test_1
    call free_mem
    popf
    ret
alloc_error:
    call allocation_error_print
    popf
    ret
bad_code endp

allocate_memory proc near
    mov dx, offset test_1
    mov cx, test_size
    call alloc_mem
    ret
allocate_memory endp

fill_memory proc near
    mov ax, 0
    mov cx, 0
    xor bx, bx
    fill_loop:
        mov bl, 41h
        add bl, cl
        call set
        inc cx
        cmp cx, test_size
        jb fill_loop
    ret
fill_memory endp

perform_test proc near uses cx bx si dx ax
    mov cx, 0
    compare_loop:
        mov bx, cx
        mov ah, buff[bx]
        mov al, [si + bx]

        cmp al, ah
        jne test_failed

        inc cx
        cmp al, 0
        jne compare_loop
    jmp test_ok

test_failed:
    call error_print
    jmp test_end

test_ok:
    call success_print
    jmp test_end

test_end:
    
    ret
perform_test endp

; RIP 24 часа моего времени чтобы понять почему все это ломается // починилось
test_format_feature proc

    call ascii_print
    call ascii_code_print
    call hex_print
    call bin_print
    call bad_code

    ret
test_format_feature endp
end
