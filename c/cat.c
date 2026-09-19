#include "stdio.h"
#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"
#include "stdbool.h"
#include <inttypes.h>
#include <string.h>

int main(int args, char *argv[]) {
    char buf[256];
    if (args == 1) {
        ssize_t n;
        while ((n = read(STDIN_FILENO, buf, sizeof buf)) > 0) {
            write(STDOUT_FILENO, buf, n);
        }
        if (n == -1) perror("read");
        close(STDIN_FILENO);
        return 0;
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
        size_t line = 1;
        int at_start = true;

        const char *option_n = "-n";
        bool is_option_n = strcmp(argv[1], option_n);
        if (is_option_n == 0) {
            while ((n = read(fd, buf, sizeof buf))> 0) {
                const char *p = buf, *end = buf + n;

                while (p < end) {
                    if (at_start) {
                        char prefix[32];
                        int len = snprintf(prefix, sizeof prefix, "%zu ", line);
                        write(STDOUT_FILENO, prefix, len);
                        at_start = false;
                    }

                    const char *nl = memchr(p, '\n', end - p);
                    if (nl) {
                        write(STDOUT_FILENO, p, nl - p + 1);
                        p = nl + 1;
                        line++;
                        at_start = true;
                    } else {
                       write(STDOUT_FILENO, p, end - p);
                       at_start = false;
                    }
                }
            }
        } else {
            while ((n = read(fd, buf, sizeof buf)) > 0) {
                write(STDOUT_FILENO, buf, n);
            }
        }

        if (n == -1) perror("read");
        close(fd);
    }

    return 0;
}
