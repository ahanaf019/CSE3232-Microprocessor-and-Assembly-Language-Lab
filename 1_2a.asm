.model small
.stack 100h

.data
prompt1 db "Enter String: $"
fc db "First Capital: $"
lc db "Last Capital: $"
nc db "No Capitals.$"
str db 25 dup(?)
strlen db 0


.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, prompt1
    mov ah, 9
    int 21h
    
    call input
    call newline  
    
    call process
    
    mov ah, 4ch
    int 21h
    
main endp

process proc
    lea si, str
    mov bl, 'Z'
    mov bh, 'A'
    
    mov ch, 0
    mov cl, strlen
     
    ctop:
        ; A--Z
        cmp [si], 'A'
        jge alabel
        jl cnt
        
        alabel:
        cmp [si], 'Z'
        jle zlabel
        jg cnt
        
        zlabel:
        cmp [si], bl
        jl fcpt
        jge nxt
        
        fcpt:
        mov bl, [si]
        
        nxt:
        cmp [si], bh
        jg lcpt
        jle cnt
        
        lcpt:
        mov bh, [si]
        
        
        cnt:        
        inc si
        loop ctop    
    
    cmp bl, 'Z' 
    je nxt1
    
    nxt1:
    cmp bh, 'A'
    je ncpprint
    jne cpprint
    
    
    ncpprint:
    lea dx, nc
    mov ah, 9
    int 21h
    ret  
    
    cpprint:
    lea dx, fc
    mov ah, 9 
    int 21h
    mov dl, bl
    mov ah, 2
    int 21h
    
    call newline
       
    lea dx, lc
    mov ah, 9 
    int 21h
    mov dl, bh
    mov ah, 2
    int 21h
        
        
    
    ret
process endp


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
    
    dec cx
    mov [si-1], "$"
    mov strlen, cl
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