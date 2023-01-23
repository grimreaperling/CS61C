#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv) {
    const char *a = "failed";
    a = "missed you";  // this is a pointer to a const value so we can change the string the pointer point to.

    char *const b = (char *) malloc(2); // this is a const pointer so we can change the value the pointer point to.
    *b = 'c';
    *(b+1) = 'n';
    printf("%s, %s\n", a, b);
}
