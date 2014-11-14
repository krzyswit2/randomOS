#!/bin/bash

cd toolchain
./compileToolchain.sh
cd ../

if [ ! -d "obj" ]; then
    mkdir obj
fi

if [ ! -d "bin" ]; then
    mkdir bin
fi

./compile.sh

qemu bin/gajOS.bin -no-reboot -no-shutdown
