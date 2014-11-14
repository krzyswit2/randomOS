#!/bin/bash
if [ ! -d "bin" ]; then
    mkdir bin
fi
gcc makeImage.c utils.c utils.h -o bin/makeImage
