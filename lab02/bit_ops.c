#include <stdio.h>
#include "bit_ops.h"

// Return the nth bit of x.
// Assume 0 <= n <= 31
unsigned get_bit(unsigned x,
                 unsigned n) {
    unsigned mid = x >> n;
    return mid - ((mid >> 1) << 1);
}
// Set the nth bit of the value of x to v.
// Assume 0 <= n <= 31, and v is 0 or 1
void set_bit(unsigned * x,
             unsigned n,
             unsigned v) {
    if (v) {
        unsigned test = 1 << n;
        *x = *x | test;
    } else {
        unsigned test = ~(1 << n);
        *x = *x & test;
    }
}
// Flip the nth bit of the value of x.
// Assume 0 <= n <= 31
void flip_bit(unsigned * x,
              unsigned n) {
    if (get_bit(*x, n)) {
        set_bit(x, n, 0);
    } else {
        set_bit(x, n, 1);
    }
}

