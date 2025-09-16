#include <stdio.h>
#include <stdint.h>

uint32_t six_middle_bits(uint32_t input);
void print_bits(uint32_t control);

int main(void) {
    uint32_t input;
    scanf("%d", &input);

    printf("Original Value = ");
    print_bits(input);

    printf("Middle Bits = ");
    uint32_t middle = six_middle_bits(input);
    print_bits(middle);
    
    printf("Middle Bits in Decimal = %d\n", middle);
}

void print_bits(uint32_t value) {
    for (int i = 0; i < 32; i++) {
        ((value >> (31 - i)) & 1u) ? putchar('1') : putchar('0');
    }
    putchar('\n');
}

// TODO: write the following function so it gets the middle 6 bits from u
uint32_t six_middle_bits(uint32_t u) {
    // Example

    // Decimal Number           = 1198362198 
    // Binary Form              = 0100 0111 0110 1101 1000 1110 0101 0110
    

    // TODO:

    return 0;
}