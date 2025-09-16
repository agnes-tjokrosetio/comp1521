////////////////////////////////////////////////////////////////////////////////
// The following program prints number of command-line arguments and each
// command-line argument on a separate line.

// Run the following commands:
// $ dcc -o print_arguments print_arguments.c
// $ ./print_arguments I love MIPS

// In the following program, what are argc and argv?
// What will be the output of the following commands?
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("argc=%d\n", argc);
    for (int i = 0; i < argc; i++) {
        printf("argv[%d]=%s\n", i, argv[i]);
    }
    return 0;
}