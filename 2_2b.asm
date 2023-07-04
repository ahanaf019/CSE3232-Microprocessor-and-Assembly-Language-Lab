.model small
.stack 100h

.data
prompt1 db "Enter N: $"
prompt2 db "Result: $"
num db 0  
pr db "PRIME$"
npr db "NOT PRIME$"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, prompt1
    int 21h
    
    mov ah, 1
    int 21h
    sub al, '0'
    mov num, al
    
    call newline
    
    mov ah, 9
    lea dx, prompt2
    int 21h 
    
    mov ch, 0
    mov cl, num
    dec cx 
    
    cmp num, 1
    je nprime
    
    cmp num, 0
    je nprime
    
    top:
    mov ah, 0
    mov al, num
    div cl
    
    cmp cl, 1
    je prime
    
    cmp ah, 0
    je nprime
    
    loop top 
    
    
    
    prime:
    mov ah, 9
    lea dx, pr
    int 21h
    jmp ext
    
    nprime:
    mov ah, 9
    lea dx, npr
    int 21h
    jmp ext
    
    ext:
    
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