#ifndef TOOLCHAIN_UTILS_H
#define TOOLCHAIN_UTILS_H
typedef struct file
{
    int size;
    char* data;
}file;

file readFile(char* path);
#endif
