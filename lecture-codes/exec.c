#include <unistd.h>
#include <sys/wait.h> //waitpid
#include <stdlib.h>

int main(int argc, char **argv) {
    pid_t pid = fork();
    if (pid == 0) {
        char *command[] = {
            "/bin/sh",
            "-c",
            argv[1],
            NULL,
        };
        execvp(command[0], command);
        char message[] = "Error\n";
        write(1, message, sizeof(message));
        exit(1);
    }
    int status;
    waitpid(pid, &status, 0);
    char str[] = "The return code is: ";
    write(1, str, sizeof(str));
    char *res = (char *) malloc(2);
    res[0] = (char) (status + 48);
    res[1] = '\n';
    write(1, res, 2);
    return 0;
}
