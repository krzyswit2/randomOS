.text
#define VGA_WIDTH $0x80

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
    
    movl pos, %ecx #tymczasowo zapisujemy pozycje kursora do rejestru
    
    cmp $0x0a, %al #line feed
    je nextLine
    
    movb %al, (%ecx) #wpisujemy znak
    inc %ecx
    movb $0x07, (%ecx) #bajt koloru: 0x07 - szary na czarnym tle
    inc %ecx
    
    movl %ecx, pos #zapisujemy zwiekszona pozycje z powrotem do pamieci
    jmp  printStr #wracamy na poczatek petli
    
    done:
        ret
        
nextLine:
    mov %ecx, %eax
    
    cdq #przekonwertuj liczbe w eax na edx:eax
    mov $160, %ebx
    div %ebx
    add %edx, %ecx
    movl %ecx, pos
    jmp printStr
