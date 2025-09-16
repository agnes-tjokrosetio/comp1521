#include <dirent.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include <string.h>

#define MAX_PATHNAME_LEN 512

void traverse_and_list(char *path);

int main(int argc, char **argv) {
    traverse_and_list(argv[1]);
}

// function to traverse through the directory recursively and print the path of
// every file and sub ... directory in the current one
void traverse_and_list(char *path) {
    // TODO    
}