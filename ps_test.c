#include "types.h"
#include "user.h"
#include "stat.h"


int main(int argc, char *argv[]) {
  int state = -1; // -1 means do not filter by state
  int pid = -1;   // -1 means do not filter by PID

  if (argc > 1) {
    state = atoi(argv[1]);
  }
  if (argc > 2) {
    pid = atoi(argv[2]);
  }

  ps(state, pid);
  exit();
}