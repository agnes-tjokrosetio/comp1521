// using FOPEN, FCLOSE
int examplefunction(void) {
    // READ from a file
    FILE *file = fopen("./text.txt", "r");
    fclose(file)
    // WRITE to a file (delete any existing data)
    FILE *file = fopen("./text.txt", "w");
    fclose(file)
    // APPEND to a file
    FILE *file = fopen("./text.txt", "a");
    fclose(file)
    // READ & WRITE to a file (doesn't delete any existing data)
    FILE *file = fopen("./text.txt", "r+");
    fclose(file)
    // READ & WRITE to a file (delete any existing data)
    FILE *file = fopen("./text.txt", "w+");
    fclose(file)
}

// using FPUTC, FWRITE, FPRINTF
int examplefunction(void) {
    // open a file in WRITE mode
    FILE *file = fopen("./text.txt", "w");
    // WRITE  a single byte to the file
    // (and move FP foward by 1 byte)
    fputc("A", file);
    // WRITE multiple bytes to the file
    // (and move FP foward by 5 bytes)
    fwrite(" test", 1, 5, file);
    // WRITE a formatted string to the file
    // (and move FP foward by 3 bytes)
    fprintf(file, "%d\n", 42)
    // close the file
    fclose(file)
}

// using FGETC
int examplefunction(void) {
    // open a file in READ mode
    FILE *file = fopen("./text.txt", "r");
    // READ a single byte from the file
    // (and move FP foward by 1 byte)
    int get_byte = fgetc(file)
    // ERROR CHECK - if we have reached EOF
    if (get_byte == EOF) {
        fprintf(stderr, "error: can't read byte");
        return 1;
    }
    // close the file
    fclose(file)
}

// using FREAD
int examplefunction(void) {
    // open a file in READ mode
    FILE *file = fopen("./text.txt", "r");
    // READ 4 bytes from the file
    // (and move FP foward by 4 bytes)
    uint8_t buffer[4];
    int get_bytes = fread(buffer, 1, 4, file);
    // ERROR CHECK - if we have read 4 bytes or reached EOF
    if (get_bytes != 4) {
        fprintf(stderr, "error: can't read 4 bytes");
        return 1;
    }
    // close the file
    fclose(file)
}

// using FGETS
int examplefunction(void) {
    // open a file in READ mode
    FILE *file = fopen("./text.txt", "r");
    // READ one line from a file (max 1024 bytes)
    // (and move FP foward by num of bytes read)
    char buffer[1024];
    fgets(buffer, 1024, file);
    // close the file
    fclose(file)
}

// using FSEEK
int examplefunction(void) {
    // open a file in READ mode
    // file pointer points to the first byte in the file
    FILE *file = fopen("./text.txt", "r");

    // move file pointer to the last byte in the file
    // (0 would be incorrect as it would be EOF)
    fseek(file, -1, SEEK_END);
    // move file pointer to the third last byte in the file
    fseek(file, -3, SEEK_END);

    // move file pointer to the first byte in the file
    fseek(file, 0, SEEK_SET);
    // move file pointer to the third byte in the file
    fseek(file, 3, SEEK_SET);

    // move file pointer forward by 64 bytes
    fseek(file, 64, SEEK_CUR);
    // move file pointer backwards by 32 bytes
    fseek(file, -32, SEEK_CUR);

    // close the file
    fclose(file)
}

// using FTELL
int examplefunction(void) {
    // open a file in READ mode
    FILE *file = fopen("./text.txt", "r");
    // READ one line from a file (max 1024 bytes)
    // (and move FP foward by num of bytes read)
    char buffer[1024];
    fgets(buffer, 1024, file);
    // get position of the file pointer
    long offset = ftell(file);
    printf("file pointer is at: %ld\n", offset);
    // close the file
    fclose(file)
}

// getting file permissions
int examplefunction(void) {
    // get the file stats
    char *pathname = "./test.txt";
    struct stat s;
    stat(pathname, &s);
    int mode = s.st_mode;
    // check READ permissions for OTHERS
    if (mode & S_IROTH) {
        printf("others have read permissions\n");
    }
    // check WRITE permissions for GROUP
    if (mode & S_IWGRP) {
        printf("group has write permissions\n");
    }
    // check EXECUTE permissions for USER (owner)
    if (mode & S_IXUSR) {
        printf("owner has execute permissions\n");
    }
    // check if a file is a directory
    if (S_ISDIR(mode)) {
        printf("file is directory\n");
    }
    // check if a file is a regular file
    if (S_ISREG(mode)) {
        printf("file is regular file\n");
    }
}

// modifying file permissions
int examplefunction(void) {
    char *pathname = "./test.txt";

    // set read perms for all users
    // set write and execute perms for file owner only
    int mode = S_IROTH | S_IRGRP | S_IRUSR | S_IWUSR | S_IWUSR;
    chmod(pathname, mode);

    // set read and write perms for user and group (mode is 0770)
    chmod(pathname, 0770);
    
    // add perms for all users to execute to existing perms
    struct stat s;
    stat(pathname, &s);
    int new_mode = s.st_mode | S_IXOTH;
    chmod(pathname, new_mode);
}

// using PERROR
int examplefunction(void) {
    FILE *file = fopen("./text.txt", "r");
    if (file == NULL) {
        // perror will print out system error message
        perror("fopen");
        exit(1);
    }

    uint8_t buffer[4];
    int get_bytes = fread(buffer, 1, 4, file);
    if (get_bytes != 4) {
        // no system error actually occured, we can't use perror
        fprintf(stderr, "expected 4 bytes but found %d\n", get_bytes);
        exit(1);
    }

    struct stat s;
    if (stat(pathname, &s) != 0) {
        // perror will print out system error message
        perror("stat");
        exit(1);
    }
}

