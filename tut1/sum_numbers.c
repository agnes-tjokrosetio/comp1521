#include <stdio.h>

int sum(int n);

int main(int argc, char *argv[]) {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);

    int result = sum(n);
    printf("Sum of all numbers up to %d = %d\n", n, result);

    return 0;
}

// TODO: rewrite the following function so it uses recursion instead of a loop.
int sum(int n) {
    // int result = 0;
    // for (int i = 0; i <= n; i++) {
    //     result += i;
    // }
    // return result;
    
    // base case
    if (n == 1) return n;
    return n + sum(n-1);
}

// sum(n) = n + sum(n-1)
// ...

// sum(2) = 2 + sum(1)
// sum(1) = 1

