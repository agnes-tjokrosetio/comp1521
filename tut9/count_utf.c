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
    // TODO

    if (argc < 2) {
        exit(1);
    }

    char *utf8_string = argv[1];
    int i = 0;
    int count_chars = 0;

    while (utf8_string[i] != '\0') {
        int length = codepoint_length(utf8_string[i]);
        i += length;
        count_chars += 1;
    }

    printf("there are %d codepoints in the string\n", count_chars);
}


// function to get the length of each utf-8 char
int codepoint_length(char byte) {
    // TODO
    // 0xxxxxxx -> 1 byte length
    if ((byte & 0b10000000) == 0b00000000) {
        return 1;
    }
    // 110xxxxx -> 2 byte length
    else if ((byte & 0b11100000) == 0b11000000) {
        return 2;
    }
    // 1110xxxx -> 3 bytes
    else if ((byte & 0b11110000) == 0b11100000) {
        return 3;
    }
    // 11110xxx -> 4 bytes
    else if ((byte & 0b11111000) == 0b11110000) {
        return 4;
    }

    return 0;
}