#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

uint64_t square(uint8_t index) {
    if (index < 1 || index > 64) return 0;
    return (uint64_t)1 << (index -1);
}

uint64_t total(void) {
    uint64_t sum = 0;
    for (unsigned int i = 1; i <= 64; i++) {
        sum += square(i);
    }
    return sum;
}

int main() {
    uint64_t res = total();
    printf("%" PRIu64 "\n", res);
    return 0;
}
