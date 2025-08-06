////////////////////////////////////////////////////////////////////////////////
// Example usage of mutex
// 
// Also recall:
//     int pthread_mutex_lock(pthread_mutex_t *mutex);
//     int pthread_mutex_unlock(pthread_mutex_t *mutex);
// 
////////////////////////////////////////////////////////////////////////////////

int bank_account = 0;
pthread_mutex_t bank_account_lock = PTHREAD_MUTEX_INITIALIZER;

// add $1 to Andrew's bank account 100,000 times
void *add_100000(void *argument){
    for (int i = 0; i < 100000; i++) {
        pthread_mutex_lock(&bank_account_lock);
        // only one thread can execute this section of code at any time
        bank_account = bank_account + 1;
        pthread_mutex_unlock(&bank_account_lock);
    }
    return NULL;
}

