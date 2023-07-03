.model small
.stack 100h

.data
str db 25 dup(?)  
strlen db 0
promt1 db "Enter string: $" 
promt2 db "Output string: $"

.code
main proc
    mov ax, @data
    mov ds, ax    
    
    mov ah, 9
    lea dx, promt1
    int 21h
    call input
    
    call newline  
    
    call case_conv  
    
    mov ah, 9  
    lea dx, promt2
    int 21h
    
    mov ah, 9  
    lea dx, str
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

input proc
    mov cx, 0
    mov ah, 1
    
    lea si, str
    
    top:
    int 21h
    
    mov [si], al
    inc si
    inc cx
    cmp al, 0dh
    jne top
    
    dec si
    dec cx
    mov [si], '$'  
    mov strlen, cl
    ret  
input endp   


case_conv proc
    lea si, str
    mov cx, 0
    mov cl, strlen
    
    ctop:
    ; A - Z
    cmp [si], 'A'
    jge A_lab
    jl next1
    
    A_lab:
    cmp [si], 'Z'
    jle Z_lab
    jg next1
    
    
    Z_lab:
    add [si], 32
    jmp next2
    
    next1:
    ; a - z
    cmp [si], 'a'
    jge sa_lab
    jl next2
    
    sa_lab:
    cmp [si], 'z'
    jle sz_lab
    jg next2
    
    
    sz_lab:
    sub [si], 32
    
    next2:
    inc si
    loop ctop
    
    
     ret
case_conv endp



end main