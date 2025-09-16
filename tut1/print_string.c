////////////////////////////////////////////////////////////////////////////////
// Programs that attempts to print a string.
// 
// Fix the following code so that it compiles and executes without error.
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>

// TODO: fix the following code, i.e. add a null terminator to the string
int main(void) {
    char str[10];
    str[0] = 'H';
    str[1] = 'i';
    printf("%s", str);
    return 0;
}