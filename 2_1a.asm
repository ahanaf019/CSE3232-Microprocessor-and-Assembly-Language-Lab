.model small

.data
prompt1 db "Enter N: $"
prompt2 db "Sum (1 to N): $"
num db 0

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
    
    mov bl, 0
    mov ch, 0
    mov cl, num
    
    top:
    add bl, cl
    loop top
    
    add bl, '0'
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