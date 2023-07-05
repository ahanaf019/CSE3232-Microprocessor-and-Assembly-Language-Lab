.model small
.stack 100h

.data
arr db dup(5)
prompt1 db "Enter 5 numbers: $"
prompt2 db "Largest number: $"

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
    
    mov [si], al
    cmp al, bl
    jg grt
    jle cnt
    
    grt:  
    mov bl, al
    
    cnt:
    inc si
    mov ah, 2
    mov dl, ' '
    int 21h
    
    
    loop top  
    
    call newline
    
    mov ah, 9
    lea dx, prompt2
    int 21h
    
    mov ah, 2
    mov dl, bl
    int 21h
    
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

end main
