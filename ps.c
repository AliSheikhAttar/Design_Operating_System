#include "types.h"
#include "user.h"
#include "fcntl.h"


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
  if (argc > 1) {
    state_t = atoi(argv[1]);
  }
  if (argc > 2) {
    pid_t = atoi(argv[2]);
  }

// Assuming enum procstate is defined elsewhere in the code

struct proc_info *process_info_t;
  process_info_t = (struct proc_info*) malloc(sizeof(struct proc_info));
  ps(state_t, pid_t, process_info_t);
  //printf("pid: %d state: %d name: %s\n", (int)process_info_t->pid, (int)process_info_t->state, (char*)process_info_t->name);
  exit();
  free(process_info_t);
}