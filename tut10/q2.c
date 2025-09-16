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


    // wait for process to finish

    
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
    
    return 0;
}


