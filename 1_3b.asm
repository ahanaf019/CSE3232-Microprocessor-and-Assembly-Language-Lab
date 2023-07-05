.model small
.stack 100h

.data
strlen db 0
prompt1 db "Enter String: $"   
prompt2 db "Sorted String: $"
str db 25 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax  
    
    lea dx, prompt1
    mov ah, 9
    int 21h
    
    call input 
    call newline 
    call sort
    
    lea dx, prompt2
    mov ah, 9
    int 21h
    
    lea dx, str
    mov ah, 9
    int 21h
    
    
    
    mov ah, 4ch
    int 21h
main endp  

sort proc
    lea si, str
    mov cx, 0
    mov cl, strlen  
    dec cx
    mov dx, 0
    
    outer:
    mov bl, cl
    lea si, str
    ;add si, dx
    
        inner:
        mov ah, [si]
        mov al, [si+1]
        
        cmp ah, al
        jg swap
        jle cnt
        
        swap:
        mov [si], al
        mov [si+1], ah
    
        cnt:
        inc si
        dec bl
        
        cmp bl, 1
        jge inner
    
    
    inc dx
    loop outer
    
    ret
sort endp



input proc
    lea si, str
    mov cx, 0
    mov ah, 1
    
    top:
        int 21h
        mov [si], al
        inc si
        inc cx
        
        cmp al, 0dh
        jne top    
    
    dec cx
    mov strlen, cl
    mov [si-1], "$"
    
    ret    
input endp

newline proc
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret
newline endp


end main