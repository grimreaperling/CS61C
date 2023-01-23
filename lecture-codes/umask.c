#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    // test of the fstat system call.
    int fd;
    fd = open("1.txt", O_RDWR);
    struct stat res;
    fstat(fd, &res);
    printf("%3o\n", (res.st_mode)&0777);

    // the test of the umask system call.
    mode_t prev;
    mode_t cur = 0777;
    prev = umask(cur);
    printf("%3o\n", prev&0777);

    return 0;
}
