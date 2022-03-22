#include <stdio.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>

int get_pid() {
    pid_t current_pid = getpid();
    char proc_p[6] = "/proc/";
    FILE* pid_file;
    pid_file = fopen("pid.txt", "a");
    fprintf(pid_file, "%s", proc_p);
    fprintf(pid_file, "%lu", current_pid);
    fclose(pid_file);
    return 0;
}

int mount_pid() {
    FILE* pid_f;
    char pid_str[16];
    pid_f = fopen("pid.txt", "r");
    fscanf(pid_f, "%s", pid_str);
    int mount_result = mount("/tmp", pid_str, "tmpfs", MS_BIND, NULL);
    if (mount_result == 0) {
        return 0;
    } else {
        return 1;
    }
}
