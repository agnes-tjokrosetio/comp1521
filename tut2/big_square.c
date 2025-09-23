// Squares a number, unless its square is too big for a 32-bit integer.
// If it is too big, prints an error message instead.

#include <stdio.h>

#define SQUARE_MAX 46340

int main(void) {
    int x, y;

    printf("Enter a number: ");
    scanf("%d", &x);

    // TODO: change the following code to use goto instead of if else statements
    // if (x > SQUARE_MAX) {
    //     printf("square too big for 32 bits\n");
    // } else {
    //     y = x * x;
    //     printf("%d\n", y);
    // }

    // return 0;

    if (x <= SQUARE_MAX) goto print_square;
    printf("square too big for 32 bits\n");
    goto end;

    print_square:
        y = x * x;
        printf("%d\n", y);

    end:
        return 0;

}