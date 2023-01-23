#include <stdio.h>
#include <stdlib.h>

int main() {
    char *str1 = "Hello";
    char *str2 = "Bye";
    void test(char* );
    void (*ptr)(char *);
    ptr = &test;
    printf("%d\n", test == &test);
    printf("%p, %p\n", test, &test);
    ptr(str1);
    (*ptr)(str2);
}

void test(char* test) {
    printf("%s\n", test);
}
