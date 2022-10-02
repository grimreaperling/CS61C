#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    uint16_t mid = *reg ^ (*reg >> 2) ^ (*reg >> 3) ^ (*reg >> 5);
    if (mid - ((mid >> 1) << 1)) {
        *reg = (1 << 15) + (*reg >> 1);
    } else {
        *reg = *reg >> 1;
    }
}

