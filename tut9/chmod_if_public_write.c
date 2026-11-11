////////////////////////////////////////////////////////////////////////////////
// Write a C program, chmod_if_public_write.c, which is given 1+ command-line
// arguments which are the pathnames of files or directories. If the file or
// directory is publically-writeable, it should change it to be not publically
// writeable, leaving other permissions unchanged (remove OTHER WRITE perms).
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

void chmod_if_needed(char *pathname);

int main(int argc, char *argv[]) {
    // TODO
    if (argc < 2) {
        fprintf(stderr, "not enough arguments");
        exit(1);
    }

    // iterate through all the provided files
    for (int i = 1; i < argc; i++) {
        chmod_if_needed(argv[i]);
    }


    return 0;
}

// function to chmod a file if publically-writeable
void chmod_if_needed(char *pathname) {
    // TODO
    struct stat s;
    stat(pathname, &s);

    // S_IWOTH has the write permissions set for the other user
    // since we want to remove it we need the negation: ~S_IWOTH
    int new_mode = s.st_mode & ~S_IWOTH; 

    // update the file permissions with the new mode (permission)
    chmod(pathname, new_mode);
}