////////////////////////////////////////////////////////////////////////////////
// This program will count the number of characters a user inputs
// Hint: use getchar() to reach in characters until CRTL-D (EOF)
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>

int main(void) {
    int count = 0;
    int c;
    while ((c = getchar()) != EOF) {
        count += 1;
    }
    printf("the number of chars enter = %d\n", count);
}



