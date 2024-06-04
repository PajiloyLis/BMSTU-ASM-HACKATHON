.model small

.stack 300h

extrn test_format_feature: near
extrn test_get_feature: near
extrn test_set_feature: near
extrn print_string: near

.data
    test_format db "Test format", 13, 10, "$"
    test_get db "Test get", 13, 10, "$"
    test_set db "Test set", 13, 10, "$"

.code 
.startup 

    mov ah, 09h
    lea dx, test_get
    int 21h

    call test_get_feature

    mov ah, 09h
    lea dx, test_set
    int 21h

    call test_set_feature

    mov ah, 09h
    lea dx, test_format
    int 21h

    ; call test_format_feature
    mov ah, 4Ch
    int 21h
end