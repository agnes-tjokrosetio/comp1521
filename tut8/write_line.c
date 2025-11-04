////////////////////////////////////////////////////////////////////////////////
// Write a C program, write_line.c, which is given one command-line argument,
// the name of a file, and which reads a line from stdin, and writes it to the
// specified file; if the file exists, it should be overwritten.
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // TODO
    if (argc < 2) {
        fprintf(stderr, "must have at least two arguments\n");
        exit(1);
    }

    char *pathname = argv[1];
    FILE *file = fopen(pathname, "w");
    if (file == NULL) {
        perror("fopen");
        exit(1);
    }

    int byte = fgetc(stdin);
    while (byte != EOF && byte != '\n') {
        fputc(byte, file);
        byte = fgetc(stdin);
    }

    fclose(file);
    

    return 0;
}