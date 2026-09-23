// Print every third number from 24 to 42.
#include <stdio.h>

int main(void) {
    // This 'for' loop is effectively equivalent to a while loop.
    // i.e. it is a while loop with a counter built in.
    for (int x = 24; x < 42; x += 3) {
        printf("%d\n", x);
    }

    // // loop_init:
    // int x = 24;
    // // loop_condition:
    // while (x < 42) {
    //     // loop_body:
    //     printf("%d\n", x);
    //     // loop_step:
    //     x += 3;
    // }
}