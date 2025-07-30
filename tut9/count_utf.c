////////////////////////////////////////////////////////////////////////////////
// Write a C program that reads a null-terminated UTF-8 string as a command
// line argument and counts how many Unicode characters (code points) it
// contains. Assume that all codepoints in the string are valid.
// Some examples of how your program should work:
//     dcc count_utf8.c -o count_utf8
//     ./count_utf8 "チョコミント、よりもあなた！"
//     there are 14 codepoints in the string
//     ./count_utf8 "早上好中国现在我有冰淇淋"
//     there are 12 codepoints in the string
//     ./count_utf8 "🤓🤓🤓🤓🤓🤓🤓🤓"
//     there are 8 codepoints in the string
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>

int codepoint_length(char byte);

int main(int argc, char **argv) {
    if (argc < 2) {
        exit(1);
    }

    char *utf8_string = argv[1];
    int count = 0;
    for (int i = 0; utf8_string[i] != '\0'; i++) {
        int length = codepoint_length(utf8_string[i]);
        count += 1;
        i += (length - 1);
    }

    printf("the string has %d codepoints in the string\n", count);

}


// function to get the length of each utf-8 char
int codepoint_length(char byte) {
    // check 1 byte
    if ((byte & 0b10000000) == 0b00000000) {
        return 1;
    }
    // check 2 bytes
    else if ((byte & 0b11100000) == 0b11000000) {
        return 2;
    }
    // check 3 bytes
    else if ((byte & 0b11110000) == 0b11100000) {
        return 3;
    }
    // check 4 bytes
    else if ((byte & 0b11111000) == 0b11110000) {
        return 4;
    }
    // invalid utf8_character
    return 0;
}