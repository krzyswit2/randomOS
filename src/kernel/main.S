.text
.global _start

_start:
    call initIo

    mov $neez, %si
    call printStr
    #mov $neez, %si
    #call printStr

    infLoop: jmp infLoop

    neez: .string "neezs\niks\noko llyp"
