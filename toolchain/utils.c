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
