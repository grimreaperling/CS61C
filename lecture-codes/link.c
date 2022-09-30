#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node{
    char *value;
    struct Node *next;
} node;

void printNode(node *list);
node *addNode(char *s, node *list);
node *deleteNode(node *list);
void appendNode(char *s, node *list);
void deleteAll(node *list);
node *joinList(node *first, node *second);

int main() {
    char *s1 = "start";
    char *s2 = "middle";
    char *s3 = "end";
    char *s4 = "new";
    node *theList = NULL;
    node *anotherList = NULL;
    node *newList = NULL;
    theList = addNode(s3, theList);
    theList = addNode(s2, theList);
    theList = addNode(s1, theList);
    theList = deleteNode(theList);
    theList = deleteNode(theList);
    theList = addNode(s4, theList);
    appendNode("append", theList);
    anotherList = addNode("list", anotherList);
    anotherList = addNode("Another", anotherList);
    printNode(theList);
    newList = joinList(theList, anotherList);
    printf("After the join: \n");
    printNode(newList);
    deleteAll(theList);
    return 0;
}

node *addNode(char *s, node *list) {
    node *new = (node *) malloc(sizeof(node));
    new->value = (char *) malloc(strlen(s) + 1);
    strcpy(new->value, s);
    new->next = list;
    return new;
}

node *deleteNode(node *list) {
    node *temp = list->next;
    free(list->value);
    free(list);
    return temp;
}

void appendNode(char *s, node *list) {
    node *new = (node *) malloc(sizeof(node));
    new->value = (char *) malloc(strlen(s) + 1);
    strcpy(new->value, s);
    node *curr = list;
    if (curr == NULL) {
       list = new;
    }
    if (curr->next != NULL) {
        curr = curr->next;
    }
    curr->next = new;
}

void deleteAll(node *list) {
    node *curr = list;
    if (curr == NULL) {
        return;
    }
    while (curr->next != NULL) {
        free(curr->value);
        curr = curr->next;
        free(list);
        list = curr;
    }
    free(curr->value);
    free(curr);
}

node *joinList(node *first, node *second) {
    node *curr = first;
    if (curr == NULL) {
        return second;
    }
    while (curr->next != NULL) {
        curr = curr->next;
    }
    curr->next = second;
    return first;
}

void printNode(node *list) {
    node *iterator = list;;
    while (iterator->next != NULL) {
        printf("%s\n", iterator->value);
        iterator = iterator->next;
    }
    printf("%s\n", iterator->value);
}
