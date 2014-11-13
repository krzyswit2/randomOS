.code16

.text
.globl _start;
_start:

jmp boot #potrzebne dla starozytnych komputerow
ret

#//////////////////////////////////////////////////

boot:
    xor %ax,%ax
    mov %ax,%es  # ES <- 0
    mov $0002,%cx   # cylinder 0, sector 2
    mov $0x080,%dx # DH = 0 (head), drive = 80h (0th hard disk)
    mov $0x7e00,%bx # segment offset of the buffer
    mov $0x201,%ax # AH = 02 (disk read), AL = 01 (number of sectors to write)
    int $0x13
    
    #real mode???
    /*
    mov $0x2401, %ax #enable A20
    int $0x15
    
    cli
    
    mov %cr0, %eax
    or %eax, 1
    mov %eax, %cr0
    
    xor %ax,%ax
    mov %ax,%es  # ES <- 0*/
    
    ljmp $0,$0x7e00
    
    infLoop: jmp infLoop
     
printStr:
          lodsb
          or  %al, %al
          jz   done
          mov $0x0e, %ah
          int  $0x10
          jmp  printStr
     done:
     ret
     
#////////////////////zeroes and signature/////////////////////////
     . = _start + 510
     .byte 0x55
     .byte 0xaa
     
#///////////////////loaded sector/////////////
newSector:
     mov $neez, %si
     call printStr
     ret
     
     neez: .string "neezs"
