#include <stdio.h>
#include <stdlib.h>

int main() {
    char *p1 = "Hello World!!";
    char p2[] = "Hello World!!";
    int *array = (int *) malloc(5 * sizeof(int));
    int *ref = array;
    ref++;
    printf("The pointer: %p\n", p1);
    printf("The array: %p\n", p2);
    printf("The literal: %p\n", "Hello World!!");
    printf("The size of the array: %lu\n", sizeof(p2));
    return 0;
}

            
