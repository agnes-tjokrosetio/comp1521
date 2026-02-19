////////////////////////////////////////////////////////////////////////////////
// Program to print a number using pointers.
// TODO: fix the following function
// => use malloc() to allocate memory with a programmer controlled lifetime
#include <stdio.h>
#include <stdlib.h>

int *get_num_ptr(void);

int main(void) {
    int *num = get_num_ptr();
    printf("%d\n", *num);
    free(num);
}

// TODO: fix the following function, i.e. use malloc()
int *get_num_ptr(void) {
    int *x = malloc(sizeof(int));
    *x = 42;
    return x;
}



