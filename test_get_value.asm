.model small

include BASE_STR.inc

extrn get: near
extrn alloc_mem: near

test_value = 15
test_normal_index = 3

.data
    test_message db "Test #$"
    failed_message db "Failed", 0Dh, 0Ah, '$'
    passed_message db "Passed", 0Dh, 0Ah, '$'
    allocation_error_message db "Error while allocation", 0Dh, 0Ah, '$'
    return_codes_error_message db "The return code is incorrect", 0Dh, 0Ah, '$'
    value_error_message db "Returned value is incorrect", 0Dh, 0Ah, '$'
    test_1 vector <>

.code
normal_index_case_1 proc near uses ax bx cx dx
    xor cx, cx
    mov cl, '1'
    call introduction_print

    mov dx, offset test_1
    mov cx, 10
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
    ret
codes_equal:
    cmp bl, byte ptr test_value
    je values_equal
    call value_error_print
    ret
values_equal:
    call success_print
    ret
normal_index_case_1 endp

introduction_print proc near uses ax dx cx
    mov ah, 09h
    mov dx, offset test_message
    int 21h 

    mov ah, 02h
    mov dl, cl
    int 21h

    mov dl, 0Dh
    int 21h

    mov dl, 0Ah
    int 21h
    
    ret
introduction_print endp

value_error_print proc near uses ax dx
    mov ah, 09h
    mov dx, offset value_error_message
    int 21h
    call error_print
    ret
value_error_print endp

return_code_error_print proc near uses ax dx
    mov ah, 09h
    mov dx, offset return_codes_error_message
    int 21h
    call error_print
    ret
return_code_error_print endp

allocation_error_print proc near uses ax dx
    mov ah, 09h
    mov dx, offset allocation_error_message
    int 21h
    call error_print
    ret
allocation_error_print endp

error_print proc near uses ax dx
    mov ah, 09h
    mov dx, offset failed_message
    int 21h
    ret
error_print endp

success_print proc near uses ax dx
    mov ah, 09h
    mov dx, offset passed_message
    int 21h
    ret
success_print endp

.startup
    call normal_index_case_1
    mov ah, 4Ch
    int 21h
end