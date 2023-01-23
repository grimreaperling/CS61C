#include <unistd.h>
#include <sys/wait.h>  // for the waitpid system call.
#include <signal.h>    // for the use of the signal.
#include <sys/types.h>
#include <stdio.h>

char * const kArguments[] = {"date", NULL};

void reapProcesses(int sig) {
  while (1) {
    pid_t pid = waitpid(-1, NULL, WNOHANG);
    if (pid <= 0) break;
    printf("Job %d removed from job list.\n", pid);
  }
}

int main(int argc, char *argv[]) {
    signal(SIGCHLD, reapProcesses);
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SIGCHLD);
    for (size_t i = 0; i < 3; i++) {
        sigprocmask(SIG_BLOCK, &set, NULL);  
        pid_t pid = fork();
        if (pid == 0) {
            sigprocmask(SIG_UNBLOCK, &set, NULL);   // We don't want to block the signal in the child process.
            execvp(kArguments[0], kArguments);
        }
        sleep(1); // force parent off CPU
        printf("Job %d added to job list.\n", pid);
        sigprocmask(SIG_UNBLOCK, &set, NULL);
    }
    return 0;
}
