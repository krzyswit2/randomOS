.text
.global _start

_start:
    call initTermIo

    mov $neezs, %si
    call printStr

    infLoop: jmp infLoop

    neezs: .string "neezs\niks\noko llyp\nkasza\nkosz\nklika\nn-klika"
