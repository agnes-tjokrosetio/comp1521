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
    DIR *dir = opendir(path);
    if (!dir) {
        perror("opendir");
        exit(1);
    }

    struct dirent *entry;
    while ((entry = readdir(dir))) {
        // filename
        char pathname[MAX_PATHNAME_LEN];
        snprintf(pathname, MAX_PATHNAME_LEN, "%s/%s", path, entry->d_name);

        // print pathname
        printf("%s\n", pathname);

        // info on file
        struct stat s;
        stat(pathname, &s);

        // check if its a directory
        if (S_ISDIR(s.st_mode)) {
            // check if current or parent directory
            if (strncmp(entry->d_name, ".", MAX_PATHNAME_LEN) == 0 || strncmp(entry->d_name, "..", MAX_PATHNAME_LEN) == 0) {
                continue;
            }
            traverse_and_list(pathname);
        }
    }

    closedir(dir);
}