#include <stdio.h>

// TODO: fix the following code so that it compiles and executes without error
// => add a null terminator to the string
int main(void) {
    char str[10];
    str[0] = 'H';
    str[1] = 'i';
    str[2] = '\0';
    printf("%s", str);
    return 0;
}