#include <stdio.h>
#include <stdlib.h>
/*
 * This file includes some code to get myself to 
 * be more familiar to the struct.
 */

void print_herbert(int number, char* name) {
    printf("The number of the student is %d, the name of the student is %s!\n", number, name);
}

typedef enum {
    add,
    mul,
    sub,
} token;

typedef struct Node {
    int data;
    struct Node* next;
} node;

typedef struct Tree {
    int data;
    struct Tree* left;
    struct Tree* right;
} tree;

typedef struct BTree {
    int data;
    struct BTree** branches;
    int branch_size;
} btree;

void print_link(node* first) {
    int i = 1;
    while (first != NULL) {
        printf("The %d element is %d ", i, first->data);
        first = first->next;
        i++;
    }
    printf("\n");
}

void print_tree(tree* root) {
    if (root == NULL) return;
    print_tree(root->left);
    print_tree(root->right);
    printf(" %d ", root->data);
}

void print_btree(btree* root) {
    if (root == NULL) return;
    if (root->branches != NULL) {
        for (int i = 0; i < root->branch_size; i++) {
            print_btree(root->branches[i]);
        }
    }
    printf(" %d ", root->data);
}

int main() {
    /* Use the function pointer as a struct field. */
    struct student {
        int number;
        char* name;
        void (*print)(int, char*);
    };
    struct student herbert = { 5, "Herbert", print_herbert };

    herbert.print(herbert.number, herbert.name);

    struct instructor {
        char* name;
        char* course;
    };
    
    struct instructor hug;
    hug.name = "Joh Hug";
    hug.course = "CS61A";
    printf("The name of the instructor is %s, the course it teaches is %s.\n", hug.name, hug.course);

    typedef struct {
        int x;
        int y;
    } point;

    point point_1 = { 1, 2 };
    printf("The x is %d, the y is %d.\n", point_1.x, point_1.y);

    // Play arounf with the link list.
    node second = { 1, NULL };
    node first = { 1, &second }; 
    print_link(&first);

    /* Some examples on the enumeration. */
    token ran = sub;
    printf("The number of the sub enumeration is %d\n", ran);

    // Play around with the binary tree.
    tree b = { 2, NULL, NULL };
    tree c = { 3, NULL, NULL };
    tree a = { 5, &b, &c};
    printf("Here is the tree: \n");
    print_tree(&a);
    printf("\n");

    // Play with the btree(aka the general tree), I just give it a casual name.
    btree branch_1[3] = {
        { 1, NULL, 0 },
        { 1, NULL, 0 },
        { 1, NULL, 0 },
    };
        
    btree** temp = malloc(sizeof(btree*) * 4);
    for (int i = 0; i < 3; i++) {
        i[temp] = &branch_1[i];
    }

    btree tree_1 = { 3, temp, 3 };
    printf("Here is the btree: \n");
    print_btree(&tree_1);
    printf("\n");
    return 0;
}
