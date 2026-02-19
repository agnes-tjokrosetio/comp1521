////////////////////////////////////////////////////////////////////////////////
// This program will count the number of characters a user inputs
// Hint: use getchar() to reach in characters until CRTL-D (EOF)
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>

int main(void) {
    int counter = 0;
    int c;
    while((c = getchar()) != EOF) {
        counter++;
    }
    printf("the number of characters entered is = %d\n", counter);
}



