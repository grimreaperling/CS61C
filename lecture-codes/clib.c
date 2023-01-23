#include <stdio.h>
#include <stdlib.h>

int main() {
    char str[] = "This is a string!";
    int arr[] = { 1, 2, 3 };
    int *array;
    array = malloc(sizeof(int) * 3);
    printf("The length of the string is %lu.\n", sizeof(str));
    printf("The size of the array is %lu, the size of the array pointer is %lu.\n", sizeof(arr), sizeof(array));

    FILE* fp;
    fp = fopen("2.txt", "r");

    int c;
    while ((c = fgetc(fp)) != EOF) {
        putchar(c);
    }

    return 0;
}
