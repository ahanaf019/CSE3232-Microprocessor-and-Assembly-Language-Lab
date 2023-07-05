.model small
.stack 100h

.data   
strlen db 0
vow db 0
conso db 0
digit db 0
space db 0
prompt1 db "Enter a String: $"
pr_vowel db "Vowels: $"
pr_conso db "Consonants: $"
pr_digit db "Digits: $"
pr_space db "Spaces: $"
str db dup(25)

.code
main proc
    mov ax, @data
    mov ds, ax
    
    
    mov ah, 9
    lea dx, prompt1
    int 21h
    
    call input
    call newline
    
    call vowel_cons
    call space_count 
    call digit_count 
    
    mov ah, 9
    lea dx, pr_vowel
    int 21h
    
    mov ah, 2
    mov dl, vow
    add dl, '0'
    int 21h
    call newline
    
    mov ah, 9
    lea dx, pr_conso
    int 21h
    
    mov ah, 2
    mov dl, conso
    add dl, '0'
    int 21h
    call newline  
    
    mov ah, 9
    lea dx, pr_digit
    int 21h
    
    mov ah, 2
    mov dl, digit
    add dl, '0'
    int 21h
    call newline 
    
    mov ah, 9
    lea dx, pr_space
    int 21h
    
    mov ah, 2
    mov dl, space
    add dl, '0'
    int 21h
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
    lea si, str
    mov cx, 0
    
    top:
        int 21h
        mov [si], al
        inc si
        inc cx
        cmp al, 0dh
        jne top
    
    dec cx    
    mov strlen, cl
    mov [si-1], '$'
    ret
input endp 


space_count proc
    lea si, str
    mov cx, 0
    mov cl, strlen
    
    stop:
        cmp [si], ' '
        je spinc
        jne cnt1
        
        spinc:
        mov ah, space
        inc ah
        mov space, ah
        
        cnt1:        
        inc si
        loop stop  

    ret
space_count endp 

digit_count proc
    lea si, str
    mov cx, 0
    mov cl, strlen
    
    dtop:
        cmp [si], '0'
        jge d0
        jl cnt2 
        
        d0:
        cmp [si], '9'
        jle dinc
        jg cnt2
        
        
        dinc:
        mov ah, digit
        inc ah
        mov digit, ah
        
        cnt2:        
        inc si
        loop dtop  

    ret
digit_count endp

vowel_cons proc
    lea si, str
    mov cx, 0
    mov cl, strlen
    
    vctop:
        ;A -- Z
        cmp [si], 'a'
        jge alabel
        jl cnt
        
        alabel:
        cmp [si], 'z'
        jle zlabel
        jg cnt
        
        ; vowels -- a, e, i, o, u
        zlabel:
        cmp [si], 'a'
        je vinc
        
        cmp [si], 'e'
        je vinc
        
        cmp [si], 'i'
        je vinc
        
        cmp [si], 'o'
        je vinc
        
        cmp [si], 'u'
        je vinc
        jne cinc
        
        
        
        vinc:
        mov ah, vow
        inc ah
        mov vow, ah 
        jmp cnt
        
        cinc:
        mov ah, conso
        inc ah
        mov conso, ah
        jmp cnt
        
        
        cnt:
        inc si
        loop vctop   
        
    ret
vowel_cons endp

end main