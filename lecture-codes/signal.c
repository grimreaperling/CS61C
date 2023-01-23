#include <unistd.h>
#include <sys/wait.h>  // for the waitpid system call.
#include <signal.h>    // for the use of the signal.
#include <sys/types.h>
#include <stdio.h>

const size_t kNumChildren = 5;
size_t numDone = 0;

void reapChild(int sig) {
    while (1) {
        pid_t pid = waitpid(-1, NULL, WNOHANG);
        if (pid <= 0) return;
        numDone++;
    }
}

int main(int argc, char **argv) {
    printf("Let my five children play while I take a nap.\n");
    signal(SIGCHLD, reapChild);
    for (int i = 1; i <= 5; i++) {
        pid_t pid = fork();
        if (pid == 0) {
            sleep(3 * i); 
            printf("Child #%d tired... returns to dad.\n", i);
            return 0;
        }
    }
    while (numDone < kNumChildren) {
        printf("At least one child still playing, so dad nods off.\n");
        sleep(5); 
        printf("Dad wakes up! ");
    }
    printf("All children accounted for.  Good job, dad!\n");
    return 0;
}
