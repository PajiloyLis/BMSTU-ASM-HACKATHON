.model small 
.386

public check_sum 
 
.code 
;/**
; * @brief Посчитать контрольную сумму с помощью алгоритма CRC-16-CCITT
; * 
; * @param ds:dx Сегмент и смещение до структуры
; * @return ax Контрольная сумма
; * @author Талышева Олеся
; */
check_sum proc uses ds si di bx 
    mov si, dx  
    mov cx, [si] 
    add si, 2  
    mov di, [si] 
    mov ax, 0ffffh   
    xor bx, bx   
crc_loop:  
    test cx, cx  
    jz crc_done  
    mov bl, [di]   
    xor bl, ah   
    mov bh, bl  
    xor bh, bl  
    shl bx, 4  
    xor bx, 1021h  
    xor bl, bl  
    shl bx, 3   
    xor ah, bl   
    shl ax, 8   
    xor ax, bx  
    inc di  
    loop crc_loop  
crc_done:  
    ret  
check_sum endp 
end
