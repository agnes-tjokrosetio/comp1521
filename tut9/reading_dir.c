int exampleFunction(void) {
    // open directory
    DIR *dir = opendir(".");
    if (!dir) {
        perror("opendir");
        exit(1);
    }
    // loop through entries
    struct dirent *entry;
    while ((entry = readdir(dir))) {
        print("%s\n", entry->d_name);
    }
    // close directory
    closedir(dir);
}

