////////////////////////////////////////////////////////////////////////////////
// Write a C program that creates a thread that infinitely prints some message 
// provided by main (eg. "Hello\n"), while the main (default) thread infinitely
// prints a different message (eg. "there!\n"). 
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdbool.h>
#include <pthread.h>
#include <unistd.h>

void *thread(void *message) {
    // TODO
}

int main() {
    // TODO
    
    return 0;
}