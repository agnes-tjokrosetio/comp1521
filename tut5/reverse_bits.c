#include <assert.h>
#include <stdio.h>

typedef unsigned int Word;

// TODO: write the following function so it reverses the order of the bits in the variable w.
Word reverseBits(Word w) {
    Word ret = 0;
    for (unsigned int bit = 0; bit < 32; bit++) {
        Word wMask = 1u << (31 - bit);
        Word retMask = 1u << bit;
        if (w & wMask) {
            ret = ret | retMask;
        }
    }

    return ret;
}

// Test
int main(void) {
    Word w1 = 0x01234567;
    // 0000 => 0000 = 0
    // 0001 => 1000 = 8
    // 0010 => 0100 = 4
    // 0011 => 1100 = C
    // 0100 => 0010 = 2
    // 0101 => 1010 = A
    // 0110 => 0110 = 6
    // 0111 => 1110 = E
    assert(reverseBits(w1) == 0xE6A2C480);
    puts("All tests passed!");
    return 0;
}