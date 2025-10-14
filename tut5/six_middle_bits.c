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
    // middle bits              = 0100 0111 0110 1MMM MMM0 1110 0101 0110
    // middle bits              = 101 100
    // decimal                  = 44
    
    // TODO:
    // => middle bits at the end u >> 13 => 0 0000 0000 0000 0100 0111 0110 1MMM MMM
    // => mask 0b000000000..000111111 => mask = 0b0000000111111

    return (u >> 13) & 0b111111;
}