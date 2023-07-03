.model small

.stack 100h

.data
prompt1 db "Enter string: $"
prompt2 db "Output string: $"
str db 25 dup(?)
strlen db 0


.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, prompt1
    int 21h
    
    call input
    call newline
    
    mov ah, 9
    lea dx, prompt2
    int 21h 
    
    call reverse
    
    
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

input proc
    mov ah, 1
    lea si, str
    mov cx, 0
    
    top:
    int 21h
    mov [si], al
    inc si
    inc cx 
    cmp al, 0dh
    jne top
    
    dec si
    dec cx
    mov [si], "$"
    mov strlen, cl
    
    ret
input endp   

reverse proc
    lea si, str
    mov cx, 0
    mov cl, strlen
    add si, cx
    dec si
    
    mov ah, 2
    ctop:
    mov dl, [si]
    int 21h
    dec si
    loop ctop
    
    
    ret
reverse endp

end main