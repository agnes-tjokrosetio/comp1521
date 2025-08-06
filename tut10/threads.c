// Example usage of pthread_create(), pthread_join() and pthread_exit()
// 
// Also recall:
//     int pthread_create(
//         pthread_t *thread,
//         const pthread_attr_t *attr,
//         void *(*thread_main)(void*),
//         void *arg
//     );
//     int pthread_join(
//         pthread_t thread,
//         void **retval
//     );
//     void pthread_exit(void *retval); 
////////////////////////////////////////////////////////////////////////////////

#include <pthread.h>
#include <stdio.h>

// Start thread execution
void *run_thread(void *argument){
    int *p = argument;
    for (int i = 0; i < 10; i++) {
        printf("Hello this is thread #%d: i = %d\n", *p, i);
    }
    // A thread finishes when either the thread's start function
    // returns, or the thread calls pthread_exit.
    return NULL;
}

int main(void) {
    // Create two threads running the same task,but different inputs.
    pthread_t thread_id1;
    int thread_number1 = 1;
    pthread_create(&thread_id1, NULL, run_thread, &thread_number1);
    pthread_t thread_id2;
    int thread_number2 = 2;
    pthread_create(&thread_id2, NULL, run_thread, &thread_number2);

    // Wait for the 2 threads to finish.
    pthread_join(thread_id1, NULL);
    pthread_join(thread_id2, NULL);
    return 0;
}

