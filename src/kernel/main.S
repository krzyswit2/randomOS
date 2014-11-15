.text
.global _start

_start:
    call initIo

    mov $neezs, %si
    call printStr
    #mov $neez, %si
    #call printStr

    infLoop: jmp infLoop

    neezs: .string "\n\n\n\n\n\n\n\n\n\nkulaa\b\nkula\b"
