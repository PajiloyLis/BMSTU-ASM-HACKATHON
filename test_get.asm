;/**
; * @file
; * @brief Модуль для тестирования функции get
; * @author Бугаков Иван ИУ7-44Б
; */

.model small

include BASE_STR.inc

public test_get_feature

extrn get: near
extrn alloc_mem: near
extrn free_mem: near
extrn introduction_print: near
extrn value_error_print: near
extrn return_code_error_print: near
extrn allocation_error_print: near
extrn error_print: near
extrn success_print: near

test_value = 15
test_normal_index = 3
test_zero_index = 0
test_size = 10
test_max_index = 9
outer_right_index = 10
outer_left_index = -1

.data
    test_1 vector <>
    test_2 vector <>
    test_3 vector <>
    test_4 vector <>
    test_5 vector <>

.code
normal_index_case_1 proc near uses ax bx cx dx
    xor cx, cx
    mov cl, '1'
    call introduction_print

    mov dx, offset test_1
    mov cx, test_size
    call alloc_mem
    cmp ax, EXIT_SUCCESS
    je allocated
    call allocation_error_print
    ret
allocated:
    mov bp, test_1.arr
    add bp, test_normal_index
    mov [bp], byte ptr  test_value
    mov dx, offset test_1
    mov cx, test_normal_index
    call get
    cmp ax, EXIT_SUCCESS
    je codes_equal
    call return_code_error_print
    jmp test_end
codes_equal:
    cmp bl, byte ptr test_value
    je values_equal
    call value_error_print
    jmp test_end
values_equal:
    call success_print
test_end:
    mov dx, offset test_1
    call free_mem
    ret
normal_index_case_1 endp

zero_index_case_2 proc near uses ax bx cx dx
    xor cx, cx
    mov cl, '2'
    call introduction_print

    mov dx, offset test_2
    mov cx, test_size
    call alloc_mem
    cmp ax, EXIT_SUCCESS
    je allocated
    call allocation_error_print
    ret
allocated:
    mov bp, test_2.arr
    add bp, test_zero_index
    mov [bp], byte ptr  test_value
    mov dx, offset test_2
    mov cx, test_zero_index
    call get
    cmp ax, EXIT_SUCCESS
    je codes_equal
    call return_code_error_print
    jmp test_end
codes_equal:
    cmp bl, byte ptr test_value
    je values_equal
    call value_error_print
    jmp test_end
values_equal:
    call success_print
test_end:
    mov dx, offset test_2
    call free_mem
    ret
zero_index_case_2 endp

max_index_case_3 proc near uses ax bx cx dx
    xor cx, cx
    mov cl, '3'
    call introduction_print

    mov dx, offset test_3
    mov cx, test_size
    call alloc_mem
    cmp ax, EXIT_SUCCESS
    je allocated
    call allocation_error_print
    ret
allocated:
    mov bp, test_3.arr
    add bp, test_max_index
    mov [bp], byte ptr  test_value
    mov dx, offset test_3
    mov cx, test_max_index
    call get
    cmp ax, EXIT_SUCCESS
    je codes_equal
    call return_code_error_print
    jmp test_end
codes_equal:
    cmp bl, byte ptr test_value
    je values_equal
    call value_error_print
    jmp test_end
values_equal:
    call success_print
test_end:
    mov dx, offset test_3
    call free_mem
    ret
max_index_case_3 endp

outer_right_index_case_4 proc near uses ax bx cx dx
    xor cx, cx
    mov cl, '4'
    call introduction_print

    mov dx, offset test_4
    mov cx, test_size
    call alloc_mem
    cmp ax, EXIT_SUCCESS
    je allocated
    call allocation_error_print
    ret
allocated:
    mov bp, test_4.arr
    add bp, outer_right_index
    mov [bp], byte ptr  test_value
    mov dx, offset test_4
    mov cx, outer_right_index
    call get
    cmp ax, INDEX_OUT_OF_RANGE
    je codes_equal
    call return_code_error_print
    jmp test_end
codes_equal:
    call success_print
test_end:
    mov dx, offset test_4
    call free_mem
    ret
outer_right_index_case_4 endp

outer_left_index_case_5 proc near uses ax bx cx dx
    xor cx, cx
    mov cl, '5'
    call introduction_print

    mov dx, offset test_5
    mov cx, test_size
    call alloc_mem
    cmp ax, EXIT_SUCCESS
    je allocated
    call allocation_error_print
    ret
allocated:
    mov bp, test_5.arr
    add bp, outer_left_index
    mov [bp], byte ptr  test_value
    mov dx, offset test_5
    mov cx, outer_left_index
    call get
    cmp ax, INDEX_OUT_OF_RANGE
    je codes_equal
    call return_code_error_print
    jmp test_end
codes_equal:
    call success_print
test_end:
    mov dx, offset test_5
    call free_mem
    ret
outer_left_index_case_5 endp

test_get_feature proc
    call normal_index_case_1
    call zero_index_case_2
    call max_index_case_3
    call outer_right_index_case_4
    call outer_left_index_case_5
    ret
test_get_feature endp
end