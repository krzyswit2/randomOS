.text

pos: .byte 0,0,0,0 #miejsce na adres nastepnego miejsca na znak

.global initIo
initIo:
    movl $0xB8000, pos
    ret
        
.global printStr
printStr:
    lodsb #zaladuj nastepny znak(wskazywany przez %si) do %al
    
    or %al, %al
    jz done #jesli %al(nastepny znak) = 0, wyjdz z petli
    
    cmp $0x0a, %al #line feed
    je nextLine
    
    movl pos, %ecx #tymczasowo zapisujemy pozycje kursora do rejestru
    movb %al, (%ecx) #wpisujemy znak
    inc %ecx
    movb $0x07, (%ecx) #bajt koloru: 0x07 - szary na czarnym tle
    inc %ecx
    movl %ecx, pos #zapisujemy zwiekszona pozycje z powrotem do pamieci
    
    jmp  printStr #wracamy na poczatek petli
    
    done:
        ret
        
nextLine:
    movl    pos, %ecx
	sub     $0xB8000, %ecx
	movl	%ecx, %eax
	mov     $160, %ebx
	cltd
	div 	%ebx #mod jest w edx
	
	mov     $160, %ebx
	sub     %edx, %ebx# ebx = 160-(edx); czyli ebx = 160-(ecx mod 80)
    add     %ebx, %ecx # ecx = ecx+80-(ecx mod 160)
    add     $0xB8000, %ecx
	movl    %ecx, pos
    jmp printStr
