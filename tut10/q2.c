////////////////////////////////////////////////////////////////////////////////
// Write a C program, now.c, which prints the following information:
//     => The current date.
//     => The current time.
//     => The current user.
//     => The current hostname.
//     => The current working directory.
// 
// Example output:
//     $ dcc now.c -o now
//     $ ./now
//     29-02-2022
//     03:59:60
//     cs1521
//     zappa.orchestra.cse.unsw.EDU.AU
//     /home/cs1521/lab08
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

extern char **environ;

void spawn_and_wait(char *args[]) {
    // create a process
    pid_t pid;
    int spawn_status = posix_spawn(&pid, args[0], NULL, NULL, args, environ);
    if (spawn_status != 0) {
        perror("posix_spawn");
        exit(1);
    }

    // wait for process to finish
    int exit_status;
    if (waitpid(pid, &exit_status, 0) == -1) {
        perror("waitpid");
        exit(1);
    }

}

int main(int argc, char *argv[]) {
    // Hint:
    // The following commands might be useful:
    //     date +%d-%m-%Y
    //     date +%T
    //     whoami
    //     hostname -f
    //     realpath .

    // TODO...
    char *argv1[] = {"/usr/bin/date", "+%d-%m-%Y", NULL};
    spawn_and_wait(argv1);

    char *argv2[] = {"/usr/bin/date", "+%T", NULL};
    spawn_and_wait(argv2);

    char *argv3[] = {"/usr/bin/whoami", NULL};
    spawn_and_wait(argv3);

    return 0;
}


