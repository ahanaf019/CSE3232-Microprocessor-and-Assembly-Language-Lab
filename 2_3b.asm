                   .model small
.stack 100h

.data
arr db dup(5)
prompt1 db "Enter 5 numbers: $"
prompt2 db "Sorted numbers: $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, prompt1
    int 21h
    
    lea si, arr
    
    mov cx, 5

    mov bl, 0
    
    top:   
    mov ah, 1
    int 21h    
    
    sub al, '0'
    mov [si], al
    inc si
    mov ah, 2
    mov dl, ' '
    int 21h
    
    loop top  
    
    call newline
    
    mov ah, 9
    lea dx, prompt2
    int 21h  
    
    call sort
    
    mov cx, 5   
    lea si, arr
    mov ah, 2
    xtop:
    mov dl, [si] 
    add dl, '0'
    int 21h
    inc si  
    
    mov dl, ' '
    int 21h
    
    loop xtop
    
    mov ah, 4ch
    int 21h
main endp

newline proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
newline endp  

sort proc
    lea si, arr
    mov cx, 4
    
    
    ctop:
        mov bl, cl
        add si, cx
        
        inner:
            
            mov al, [si] 
            
            cmp al, [si-1]
            jg swap
            jle cnt
            
            swap:
            mov ah, [si-1]
            mov [si-1], al
            mov [si], ah
        
            
            cnt:
            dec bl
            dec si
            cmp bl, 1
            jg inner
        
    
    loop ctop
    
    ret
sort endp

end main
