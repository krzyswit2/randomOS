#!/bin/bash

cd src/kernel
./compileKernel.sh
cd ../../

as src/boot/boot.S -o obj/boot.o
ld obj/boot.o --oformat=binary -Ttext 0x7c00 -o bin/boot.bin

toolchain/bin/makeImage
