.model small

.code
proc alloc_mem

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
        xor ax, ax
        ret

    epic_fail:
        mov ax, 1h
        ret
    

alloc_mem endp