////////////////////////////////////////////////////////////////////////////////
// This program scans in a number n and prints the sum of all integers up to
// and including n.
// 
// 1. Rewrite sum() so it uses recursion instead of a loop
// 
// 2.1 What happens in memory when this program runs?
// 2.2 What is the difference between the loop and recursive versions?
////////////////////////////////////////////////////////////////////////////////

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
    
    if (n == 1) return 1; // base case
    return n + sum(n - 1); // recursive step

    // using ternary operators
    // return (n == 1) ? 1 : n + sum(n - 1);
}

