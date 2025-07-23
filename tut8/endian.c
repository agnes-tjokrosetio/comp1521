#include <stdio.h>

int main() {
    unsigned int value = 0x1234;

    // Convert the integer's address to a character pointer, allowing byte-level access
    char *ptr = (char *)&value;

    // If the first byte pointed to by ptr is 0x12 (most significant byte), system is big-endian.
    // If the first byte pointed to by ptr 0x34 (least significant byte), system is little-endian. 
    if (*ptr == 0x12) {
        printf("Big-endian\n");
    } else {
        printf("Little-endian\n");
    }

    return 0;
}