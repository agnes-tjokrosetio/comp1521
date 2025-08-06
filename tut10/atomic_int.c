////////////////////////////////////////////////////////////////////////////////
// Example usage of atomic_int
////////////////////////////////////////////////////////////////////////////////

#include <stdatomic.h>

atomic_int bank_account = 0;

// add $1 to Andrew's bank account 100,000 times
void *add_100000(void *argument){
    for (int i = 0; i < 100000; i++) {
        // NOTE: This cannot be `bank_account = bank_account + 1`,
        // as that will not be atomic!
        // `bank_account++` would be okay
        // `bank_account += 1` would also be okay
        atomic_fetch_add(&bank_account,1)
    }
    return NULL;
}

