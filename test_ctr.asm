;/**
; * @file
; * @brief Модуль для тестирования функции check_sum
; * @author Талышева Олеся ИУ7-45Б
; */


.386
.model small
public test_control
extrn check_sum: near

.data
    test_data1 db 5, 'hello'   
    test_data2 db 3, 'abc'    
    test_data3 db 11, 'assembly test' 
    expected_result1 dw 0xD26E 
    expected_result2 dw 0x514A 
    expected_result3 dw 0x1FDB
    pass_msg db 'All tests passed!', 0Dh, 0Ah, '$'
    fail_msg db 'Test failed!', 0Dh, 0Ah, '$'

.code
test_control_feature proc
    mov ax, @data
    mov ds, ax

    lea dx, test_data1
    call check_sum
    cmp ax, expected_result1
    je test1_passed
    mov ah, 09h
    lea dx, fail_msg
    int 21h
    ret

test1_passed:
    lea dx, test_data2
    call check_sum
    cmp ax, expected_result2
    je test2_passed
    mov ah, 09h
    lea dx, fail_msg
    int 21h
    ret

test2_passed:
    lea dx, test_data3
    call check_sum
    cmp ax, expected_result3
    je test3_passed
    mov ah, 09h
    lea dx, fail_msg
    int 21h
    ret

test_control:
    mov ah, 09h
    lea dx, pass_msg
    int 21h

test_control_feature endp

end