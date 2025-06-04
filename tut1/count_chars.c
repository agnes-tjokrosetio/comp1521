#include <stdio.h>

// TODO: write a function to count the number of characters a user inputs
// => use getchar() to reach in characters until CRTL-D (EOF)
int main(void) {

    int count = 0;
    int c;

    while ((c = getchar()) != EOF) {
        count++;
    }

    printf("the number of characters entered is = %d", count);

}




