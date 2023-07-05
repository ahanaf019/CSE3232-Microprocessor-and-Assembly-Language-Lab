.model small
.stack 100h

.data
strlen db 0
patlen db 0
prompt1 db "Enter string: $"
prompt2 db "Longest sequence: $"
str db 25 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, prompt1
    mov ah, 9
    int 21h
    
    call input
    call newline
    
    lea dx, prompt2
    mov ah, 9
    int 21h  
    
    call process 
    
    inc bh
    add bh, '0' 
    mov dl, bh
    mov ah, 2
    int 21h
    
    
    
    mov ah, 4ch
    int 21h
main endp 

process proc
    lea si, str
    mov cx, 0
    mov cl, strlen
    
    mov bl, patlen
    mov bh, 0
    
    xtop: 
        mov al, [si]
        mov ah, [si+1]
        cmp al, ah
        jle patinc
        jg cnt
        
        patinc:
        inc bl
        inc si
        dec cx
        cmp cx, 1
        jge xtop
    
        cnt:
        cmp bl, bh
        jg grt
        jle cnt1
        
        grt:
        mov bh, bl 
        jmp cnt1
        
        cnt1:
        mov bl, 0
        inc si 
        dec cx
        cmp cx, 1
        jge xtop
    
    ret
process endp

input proc
    lea si, str
    mov ah, 1
    mov cx, 0
    
    top:
        int 21h
         
        inc cx
        mov [si], al  
        inc si
        cmp al, 0dh
        jne top
        
        dec cl
        mov strlen, cl
        mov [si], "$"
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