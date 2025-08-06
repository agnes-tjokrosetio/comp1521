////////////////////////////////////////////////////////////////////////////////
// Example usage of posix_spawn() and waitpid()
// 
// Also recall:
//     int posix_spawn(
//         pid_t *pid, const char *path,
//         const posix_spawn_file_actions_t *file_actions,
//         const posix_spawnattr_t *attrp,
//         char *const argv[], char *const envp[]);
//     pid_t waitpid(pid_t pid, int *wstatus, int options);
// 
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/wait.h>
#include <spawn.h>

int main(void) {

    // create a process
    char *ls_argv[] = {"/bin/ls", "-ld", NULL};
    pid_t pid; extern char **environ; int ret;
    if ((ret = posix_spawn(&pid, ls_argv[0], NULL, NULL, ls_argv, environ)) != 0) {
        errno = ret;
        perror("spawn");
        exit(1);
    }

    // wait for process to finish
    int exit_status;
    if (waitpid(pid, &exit_status, 0) == -1) {
        perror("waitpid");
        exit(1);
    }

    return 0;
}
