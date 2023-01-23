#include <fcntl.h> 
#include <unistd.h>

int main() {
    int fd;
    fd = open("1.txt", O_RDONLY);
    char buff[1024];
    int n = read(fd, buff, 1024);
    int res = write(1, buff, n);

    int pid = fork();
    if (pid != 0) {
        char first[] = "The parent!\n";
        write(1, first, sizeof(first)); 
    } else {
        char second[] = "The child!\n";
        write(1, second, sizeof(second));
    }
    return 0;
}
