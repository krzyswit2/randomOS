#include <stdio.h>
#include <stdlib.h>
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
    
    FILE* out = fopen("bin/gajOS.bin", "wb");
    fwrite(bootloader.data, 512, 1, out);
    fwrite(kernel.data, 1, kernel.size, out);
    
    fclose(out);
    free(bootloader.data);
    free(kernel.data);
    
    return 0;
}
