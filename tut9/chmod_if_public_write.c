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
    for (int arg = 1; arg < argc; arg++) {
        chmod_if_needed(argv[arg]);
    }

    return 0;
}

// function to chmod a file if publically-writeable
void chmod_if_needed(char *pathname) {
    // TODO
    struct stat s;
    stat(pathname, &s);
    // no public write perms => ~S_IWOTH
    // update new perms => s.st_mode & ~S_IWOTH
    int new_mode = s.st_mode & ~S_IWOTH;
    chmod(pathname, new_mode);
}