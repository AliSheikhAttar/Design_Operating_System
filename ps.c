#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
// Assuming enum procstate is defined in a shared header
enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

struct proc_info {
    enum procstate state;  // Process state
    int pid;               // Process ID
    struct proc *parent;   // Parent process
    char name[16];         // Process name (debugging)
};

int main(int argc, char *argv[]) {
    int state_t = -1; // -1 means do not filter by state
    int pid_t = -1;   // -1 means do not filter by PID
    char* name_t = "None";

    if (argc > 1)
        if (argv[1][0] != '-')
            state_t = atoi(argv[1]);
    
    if (argc > 2)
        if (argv[2][0] != '-')
            pid_t = atoi(argv[2]);
    
    if (argc > 3)
        name_t = argv[3];
    
    printf(1, "state-userspace: %d\n", state_t);
    printf(1, "id-userspace: %d\n", pid_t);
    printf(1, "name-userspace: %s\n", name_t);

    struct proc_info *process_info_t;
    process_info_t = (struct proc_info*) malloc(sizeof(struct proc_info));
    
    // Make sure ps function is defined somewhere accessible

    ps(state_t, pid_t, name_t, process_info_t);

    free(process_info_t);  // free before exit
    exit();  // use exit properly
}
