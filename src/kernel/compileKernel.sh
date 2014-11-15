#!/bin/bash

as --32 terminalio.S -o ../../obj/terminalio.o
    as --32 main.S -o ../../obj/kernel.o

ld ../../obj/kernel.o ../../obj/terminalio.o -melf_i386 --oformat=binary -Ttext 0x7e04 -o ../../bin/kernel.bin
