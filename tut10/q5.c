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
    while (true) {
        printf("%s", (char *)message);
        sleep(1);
    }

    return NULL;

}

int main() {
    // TODO
    char *message = "hello\n";

    pthread_t thread_id;
    pthread_create(&thread_id, NULL, thread, message);

    while (true) {
        printf("there\n");
        sleep(3);
    }

    pthread_join(thread_id, NULL);
    
    return 0;
}