// A simple program demonstrating how to represent a implementing an && in an
// if-statement in MIPS.

#include <stdio.h>

int main(void) {
    int x;
    printf("Enter a number: ");
    scanf("%d", &x);

    char *message = "small/big\n";
    // x > 100 => mips use opp: less than or equal
    // x < 1000 => mips use opp: greater than or equal
    if (x > 100 && x < 1000) {
        message = "medium";
    }

    printf("%s", message);
}