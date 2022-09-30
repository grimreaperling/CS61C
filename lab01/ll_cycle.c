#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    node *tortoise = head;
    node *hare = head;
    while (hare != NULL && tortoise != NULL) {
        if (hare->next == NULL || hare->next->next == NULL) {
            return 0;
        }
        hare = hare->next;
        hare = hare->next;
        tortoise = tortoise->next;
        if (tortoise == hare) {
            return 1;
        }
    }
    return 0;
}
