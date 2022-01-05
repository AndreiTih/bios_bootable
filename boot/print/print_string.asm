print_string: ; Function that prints the string starting at the address inside the bx register
pusha
mov ah , 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

printFLoop1:
mov cl, [bx]
cmp cl, 0
je printFEnd
;Print the first character at the bx address
mov al, [bx] ; then copy bl ( i.e. 8- bit char ) to al
int 0x10 ; print (al)
inc bx ;Increment address
jmp printFLoop1
printFEnd:
popa
ret