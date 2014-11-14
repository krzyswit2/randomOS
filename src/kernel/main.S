.text
.global _start

_start:
    call initIo

    mov $neezs, %si
    call printStr
    #mov $neez, %si
    #call printStr

    infLoop: jmp infLoop

    neezs: .string "neezs\niks\noko llyp\nkasza\nkosz\nklika\nnklika"
