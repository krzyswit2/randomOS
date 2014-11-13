#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
file readFile(char* path)
{
    file ret;
	char* buffer = 0;
	long length;
	FILE* f = fopen(path, "rb");

	if(f)
	{
		fseek(f, 0, SEEK_END);
		length = ftell(f);
		fseek(f, 0, SEEK_SET);
		buffer = malloc(length);
		if(buffer)
		{
			fread(buffer, 1, length, f);
		}
		fclose(f);
	}

    ret.data = buffer;
    ret.size = length;
    return ret;
}
