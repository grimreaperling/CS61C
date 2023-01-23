#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    // Prepare the fds array for the pipe 
    int fds[2];
    int status = pipe(fds);
    char buff[1024];

    pid_t pid = fork();
    if (pid == 0) {
        char mes[] = "This is the child process!\n";
        write(1, mes, sizeof(mes));
        char from[] = "This is the message from the child process!\n";
        write(fds[1], from, sizeof(from));
        exit(0);
    }
    // Synchronize with the child process.
    waitpid(pid, &status, 0);

    char mes[] = "This is the parent process!\n";
    write(1, mes, sizeof(mes));

    int bytes = read(fds[0], buff, 1024);
    write(1, buff, bytes);

    return 0;
}
