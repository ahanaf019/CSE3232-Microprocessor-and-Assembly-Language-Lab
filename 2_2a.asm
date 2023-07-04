.model small

.data
prompt1 db "Enter N: $"
prompt2 db "Result: $"
num db 0  
ev db "EVEN$"
od db "ODD$"

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
    
    mov ah, 0
    mov al, num
    mov dl, 2
    div dl
    
    cmp ah, 0
    je even
    jne odd
    
    even:
    mov ah, 9
    lea dx, ev
    int 21h
    jmp ext
    
    odd:
    mov ah, 9
    lea dx, od
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