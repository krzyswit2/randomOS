/*
    randomOS - basic operating system
    Copyright (C) 2014  krzygorz

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "format.h"
#include "utils.h"

int main(char** argv, int argc)
{
    file bootloader = readFile("bin/boot.bin");
    if(bootloader.size != 512)
    {
        printf("invalid size of bootloader!\n");
        return 1;
    }
    file kernel = readFile("bin/kernel.bin");
    
    KernelHeader header = 
    {
        0xbaba,
    };
    
    FILE* out = fopen("bin/gajOS.bin", "wb");
    fwrite(bootloader.data, 512, 1, out);
    fwrite(&header, 1, sizeof(KernelHeader), out);
    fwrite(kernel.data, 1, kernel.size, out);
    
    fclose(out);
    free(bootloader.data);
    free(kernel.data);
    
    return 0;
}
