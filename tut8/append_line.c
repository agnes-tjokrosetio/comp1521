////////////////////////////////////////////////////////////////////////////////
// Write a C program, write_line.c, which is given one command-line argument,
// the name of a file, and which reads a line from stdin, and appends it to the
// specified file.
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // TODO
    if (argc < 2) {
        fprintf(stderr, "must need 2 arguments");
        exit(1);
    }

    char *pathname = argv[1];
    FILE *file = fopen(pathname, "a");
    if (file == NULL) {
        perror("fopen");
        exit(1);
    }

    int byte = fgetc(stdin);
    while (byte != EOF && byte != '\n') {
        fputc(byte, file);
        byte = fgetc(stdin);
    }

    fprintf(file, "\n");

    return 0;
    return 0;
}