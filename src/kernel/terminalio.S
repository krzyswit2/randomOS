/*
    randomOS - basic operating system
    Copyright (C) 2014  krzygorz

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

.text

pos: .byte 0,0,0,0 #miejsce na adres nastepnego miejsca na znak

.global initTermIo
initTermIo:
    movl $0xB8000, pos
    call clnScr
    ret
       
.global clnScr
clnScr:
    movl $0xB8000, pos
    mov $0xB8000, %ecx
    loop:
        movw $0x20, (%ecx)
        
        cmp $0xB87D0, %ecx
        je doneClnScr
        
        inc %ecx
        inc %ecx
        jmp loop
    doneClnScr:
        ret
    
.global printStr
printStr:
    lodsb #zaladuj nastepny znak(wskazywany przez %si) do %al
    
    or %al, %al
    jz donePrintStr #jesli %al(nastepny znak) = 0, wyjdz z petli
    
    cmp $0x0a, %al #line feed
    je nextLine
    
    movl pos, %ecx #tymczasowo zapisujemy pozycje kursora do rejestru
    movb %al, (%ecx) #wpisujemy znak
    inc %ecx
    movb $0x07, (%ecx) #bajt koloru: 0x07 - szary na czarnym tle
    inc %ecx
    movl %ecx, pos #zapisujemy zwiekszona pozycje z powrotem do pamieci
    
    jmp  printStr #wracamy na poczatek petli
    
    donePrintStr:
        ret
        
nextLine:
    movl    pos, %ecx
	sub     $0xB8000, %ecx #odejmujemy poczatkowy adres
	movl	%ecx, %eax
	mov     $160, %ebx #160 = szerokosc ekranu w znakach * 2
	cltd    #przekonwertuj liczbe w eax na edx:eax
	div 	%ebx #mod jest w edx
	
	mov     $160, %ebx
	sub     %edx, %ebx# ebx = 160-(edx); czyli ebx = 160-(ecx mod 80)
    add     %ebx, %ecx # ecx = ecx+80-(ecx mod 160)
    add     $0xB8000, %ecx
	movl    %ecx, pos
    jmp printStr
