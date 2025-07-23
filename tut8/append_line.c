#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "must have at least one agrument\n");
        exit(1);
    }

    char *pathname = argv[1];
    FILE *file = fopen(pathname, "a");

    int byte = fgetc(stdin);
    while (byte != EOF && byte != '\n') {
        fputc(byte, file);
        byte = fgetc(stdin);
    }

    fclose(file);

    return 0;
}