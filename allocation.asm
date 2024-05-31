.model small

.stack 100h

extrn EXIT_SUCCESS:ABS
extrn ALLOCATION_ERROR:ABS

.code
alloc_mem proc

    mov bx, dx
    xor dx, dx
    mov ax, cx

    mov si, cx

    mov cx, 10h
    div cx
    
    test dx, dx
    jz skip
    inc ax
    skip:
    mov di, bx
    mov bx, ax
    
    mov ah, 48h
    int 21h
    jc epic_fail
    
    mov ds:[di], si
    mov ds:[di + 2h], ax

    epic_success:
        mov ax, EXIT_SUCCESS
        ret

    epic_fail:
        mov ax, ALLOCATION_ERROR
        ret
    
alloc_mem endp
END