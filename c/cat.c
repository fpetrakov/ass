#include "stdio.h"
#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"

int main(int args, char *argv[]) {
    char buf[256];
    if (args == 1) {
        ssize_t n;
        while ((n = read(STDIN_FILENO, buf, sizeof buf))) {
            write(STDOUT_FILENO, buf, n);
        }
        if (n == -1) perror("read");
        close(STDIN_FILENO);
    }

    struct stat st;
    for (unsigned int i = 1; i < args; i++) {
        int fd = open(argv[i], O_RDONLY);
        if (fd == -1) { perror("open"); continue; }

        if (fstat(fd, &st) == -1) {
            perror("fstat");
            close(fd);
            continue;
        }

        if (S_ISDIR(st.st_mode)) {
            fprintf(stderr, "cat: %s: Is a directory\n", argv[i]);
            close(fd);
            continue;
        }

        ssize_t n;
        while ((n = read(fd, buf, sizeof buf))) {
            write(STDOUT_FILENO, buf, n);
        }
        if (n == -1) perror("read");
        close(fd);
    }
    return 0;
}
