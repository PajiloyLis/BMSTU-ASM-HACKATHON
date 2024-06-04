.model small

public introduction_print
public value_error_print
public return_code_error_print
public allocation_error_print
public error_print
public success_print
public print_string

.data
    test_message db "Test #$"
    failed_message db "Failed", 0Dh, 0Ah, '$'
    passed_message db "Passed", 0Dh, 0Ah, '$'
    allocation_error_message db "Error while allocation", 0Dh, 0Ah, '$'
    return_codes_error_message db "The return code is incorrect", 0Dh, 0Ah, '$'
    value_error_message db "Returned value is incorrect", 0Dh, 0Ah, '$'
    
.code
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

print_string proc uses ax dx
    mov ah, 09h
    mov dx, si
    int 21h 
print_string endp

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
end