.code16

.text
.globl _start;
_start:

jmp boot #potrzebne dla starozytnych komputerow

boot:
readCode:
    xor %ax,%ax
    mov %ax,%es  # ES <- 0
    mov $0002,%cx   # cylinder 0, sector 2
    mov $0x080,%dx # DH = 0 (head), drive = 80h (0th hard disk)
    mov $0x7e00,%bx # segment offset of the buffer
    mov $0x201,%ax # AH = 02 (disk read), AL = 01 (number of sectors to write)
    int $0x13
    
setupEnv:
    xor %ah,%ah
    mov $0x1112, %ax
    int $0x10

real2prot:
        mov $0x2401, %ax #enable A20(BIOS way)
        int $0x15
        
        cli #wylaczamy przerwania
        
        lgdt gdtdesc #load gdt
        
        movl %cr0, %eax
        orl $1, %eax #set PE bit
        movl %eax, %cr0
    
    ljmp $0x08,$0x7e00 #long jump do zaladowanej pamieci
                       #0x08 - code segment w GDT, 0x7e00 - adres, na ktorym znajduje
                       #sie zaladowany kod
    
    infLoop: jmp infLoop
     
/*
    GDT - Global Descriptor Table
    Tu sie zapisuje segmenty pamieci i ich uprawnienia
    Bazowalem to na GRUBie
    http://wiki.osdev.org/GDT_Tutorial
*/
gdt:
    #null descriptor
        .word 0, 0
        .byte 0, 0, 0, 0

    /*
     code segment
     base = 0x00000000, limit = 0xFFFFF (4 KiB Granularity), present
     type = 32bit code execute/read, DPL = 0
    */
        .word 0xFFFF, 0
        .byte 0, 0x9A, 0xCF, 0

    /* 
     data segment
     base = 0x00000000, limit 0xFFFFF (4 KiB Granularity), present
     type = 32 bit data read/write, DPL = 0
    */
        .word 0xFFFF, 0
        .byte 0, 0x92, 0xCF, 0
    
gdtdesc:
    .word 0x18 /* limit */
    .long gdt /* addr */
     
#////////////////////zeroes and signature/////////////////////////
     . = _start + 510
     .byte 0x55
     .byte 0xaa #55aa to sygnatura potrzebna, by zbootowac system z dysku,
                #musi znajdowac sie na 510 bicie
