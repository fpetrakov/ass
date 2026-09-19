#define _GNU_SOURCE
#include "sys/socket.h"
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include "stdio.h"

int main() {
    int fd = socket(AF_INET, SOCK_STREAM, 0);
    if (fd == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    int enable = true;
    if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(enable)) < 0) {
        perror("setsocketopt");
        close(fd);
        exit(EXIT_FAILURE);
    }

    struct sockaddr_in address;
    address.sin_family = AF_INET;
    address.sin_port = htons(8080);
    address.sin_addr.s_addr = htonl(INADDR_ANY);

    if ((bind(fd, (struct sockaddr *) &address, 16)) < 0) {
        perror("bind");
        exit(EXIT_FAILURE);
    }

    if ((listen(fd, 0)) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    const char *okay = "HTTP/1.0 200 OK\r\n\r\n";
    const char *not_okay = "HTTP/1.0 500 ERROR\r\n\r\n";
    char buf[4096];
    ssize_t n;

    while (true) {
        int accept_fd = accept(fd, 0, 0);
        if (accept_fd == -1) {
            perror("accept");
            exit(EXIT_FAILURE);
        }

        size_t len = 0;
        char *header_end = NULL;

        while (!header_end && len < sizeof buf) {
            n = read(accept_fd, buf + len, sizeof buf - len);
            if (n == -1) {
                perror("read");
                break;
            }
            if (n == 0) {
                break;
            }
            len += n;
            header_end = memmem(buf, len, "\r\n\r\n", 4);
        }
        if (header_end) {
            write(accept_fd, okay, strlen(okay));
            const char *end = buf + n;
            const char *first_space_char = memchr(buf, ' ', end - buf);
            if (first_space_char) {
                const char *start = first_space_char + 1;
                const char *second_space_char = memchr(start, ' ', end - start);
                if (second_space_char) {
                    write(accept_fd, start, second_space_char - start);
                }
            }
        } else {
            write(accept_fd, not_okay, strlen(not_okay));
        }

        if (close(accept_fd) == -1) {
            perror("close");
            exit(EXIT_FAILURE);
        }
    }

    exit(EXIT_SUCCESS);
}
