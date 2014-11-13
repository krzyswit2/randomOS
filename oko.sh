#!/bin/bash

cd toolchain
./compileToolchain.sh
cd ../

./compile.sh
qemu bin/gajOS.bin -no-reboot -no-shutdown
