.model small
.stack 100h

.data
prompt1 db "Enter N: $"
prompt2 db "Factorial N: $"
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
    
    mov al, 1
    mov ch, 0
    mov cl, num
    cmp cl, 0
    je print
    
    top:
    mul cl
    loop top
    
    
    print:
    mov dl, al
    add dl, '0'
    mov ah, 2
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

