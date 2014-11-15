.text
.global _start

_start:
    call initIo

    mov $neezs, %si
    call printStr

    infLoop: jmp infLoop

    neezs: .string "\n\n\n\n\n\n\n\n\n\n\t\tkoza\rklika"
