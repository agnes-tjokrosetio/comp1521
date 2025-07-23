////////////////////////////////////////////////////////////////////////////////
// Write a C program, first_line.c, which is given one command-line argument,
// the name of a file, and which prints the first line of that file to stdout.
// If given an incorrect number of arguments, or if there was an error opening
// the file, it should print a suitable error message.
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // TODO
    if (argc < 2) {
        fprintf(stderr, "must have at least one argument\n");
        exit(1);
    }

    char *pathname = argv[1];
    FILE *file = fopen(pathname, "r");
    if (file == NULL) {
        perror("fopen failed");
        exit(1);
    }

    char buffer[1024];
    fgets(buffer, 1024, file);
    for (int i = 0; buffer[i] != '\0'; i++) {
        fputc(buffer[i], stdout);
    }

    fclose(file);

    return 0;
}