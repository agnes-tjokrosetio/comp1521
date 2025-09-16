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
}


// function to get the length of each utf-8 char
int codepoint_length(char byte) {
    // TODO
}