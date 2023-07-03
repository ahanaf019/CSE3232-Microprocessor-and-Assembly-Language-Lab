.model small

.stack 100h
 
.data
prompt1 db "Enter string: $"
strlen db 0
prompt2 db "Output string: $"
 

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, prompt1
    int 21h   
    
    call input
    call newline

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
    mov cx, 0
    
    top:
    int 21h
    push ax
    inc cx
    cmp al, 0dh
    jne top
    
    pop ax
    dec cx
    
    call newline 
    
    mov ah, 9
    lea dx, prompt2
    int 21h
    
    ctop:
    pop ax
    mov ah, 2
    mov dl, al
    int 21h
    loop ctop
    
        
input endp 


end main