#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
// #include "umalloc.c"
// #include <stdio.h>
struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;
int time_slice = DEFAULT_TIME_SLICE;
int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->init_time = ticks;
  p->pid = nextpid++;
  p->time_slice = 0; 
  p->terminate_time = 0; 
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  curproc->terminate_time = ticks;
  curproc->init_time = 0;
  cprintf("process %s (%d)finished -----------------------------------------------------\n",p->name, p->pid);
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  int terminated = 0;

  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.

    acquire(&ptable.lock);
    terminated = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&(c->scheduler), p->context);
      if (p->terminate_time >0 && terminated == 0)
      { 
        terminated += 1;
        cprintf("turnaround time is for process %s (pid = %d) is %d\n\n",p->name, p->pid, (p->terminate_time - p->init_time));
      }
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    if (terminated == 0)
    {
        if (time_slice > 1000000)
        {
          time_slice = 2;
        }
        else{
          time_slice *= 2;
        }
        
    }

    release(&ptable.lock);

    
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.

void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
int compareStrings(const char *str1, const char *str2) {
    while (*str1 && (*str1 == *str2)) {
        str1++;
        str2++;
    }

    return *(unsigned char *)str1 - *(unsigned char *)str2;
}



int mstrcmp(const char *str1, const char *str2) {
    // Check each character of both strings
    while (*str1 && *str2) {
        // If characters differ, strings are not equal
        if (*str1 != *str2) {
            return 0;
        }
        // Move to the next character
        str1++;
        str2++;
    }
    // If both strings reached the end, they are equal
    return *str1 == '\0' && *str2 == '\0';
}

int sys_ps(void) {

  int state_t = -1;  // Default to no filtering by state
  int pid_t = -1; 
  char* name_t = "None";   // Default to no filtering by PID
  struct proc *p;
  char *state_name;
  char *parent_state_name;
  int found = 0;
  // Try to get state_t from user space, but don't fail if not provided
  if (argint(0, &state_t) < 0)
    state_t = -1;  // No input provided, so use default value

  // Try to get pid_t from user space, but don't fail if not provided
  if (argint(1, &pid_t) < 0)
    pid_t = -1;  // No input provided, so use default value

  if(argstr(2, &name_t) < 0){
    name_t = "None";  
  }
  

  cprintf("state-kernelspace: %d\n",pid_t);
  cprintf("state-kernelspace: %d\n",state_t);
  cprintf("name-kernelspace: %s\n",name_t);

  // Iterate through the process table
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {   
    // Map the process state to its string representation
    switch (p->state) {
      case UNUSED:   state_name = "UNUSED";   break;
      case EMBRYO:   state_name = "EMBRYO";   break;
      case SLEEPING: state_name = "SLEEPING"; break;
      case RUNNABLE: state_name = "RUNNABLE"; break;
      case RUNNING:  state_name = "RUNNING";  break;
      case ZOMBIE:   state_name = "ZOMBIE";   break;
      default:       state_name = "UNKNOWN";  break;
    }

    // Map the parent process state to its string representation
    if (p->parent) {  // Ensure p->parent is not null
      switch (p->parent->state) {
        case UNUSED:   parent_state_name = "UNUSED";   break;
        case EMBRYO:   parent_state_name = "EMBRYO";   break;
        case SLEEPING: parent_state_name = "SLEEPING"; break;
        case RUNNABLE: parent_state_name = "RUNNABLE"; break;
        case RUNNING:  parent_state_name = "RUNNING";  break;
        case ZOMBIE:   parent_state_name = "ZOMBIE";   break;
        default:       parent_state_name = "UNKNOWN";  break;
      }
    } else {
      parent_state_name = "N/A";
    }

  
        // Check for PID filter
        if (pid_t != -1 && p->pid == pid_t) {
            cprintf("pid: %d state: %s name: %s ppid: %d pstate: %s\n",
                    p->pid, state_name, p->name,
                    p->parent ? p->parent->pid : -1, parent_state_name);
            found = 1;
            return 0; // Found the specific process, return immediately
        }

        // Check for state filter
        if (state_t != -1 && p->state == state_t) {
            cprintf("pid: %d state: %s name: %s ppid: %d pstate: %s\n",
                    p->pid, state_name, p->name,
                    p->parent ? p->parent->pid : -1, parent_state_name);
            found = 1;
        }

        // Check for name filter
        if(mstrcmp(name_t,"None")==0) {
          if(mstrcmp(p->name,name_t)!=0){
            cprintf("pid: %d state: %s name: %s ppid: %d pstate: %s\n",
                    p->pid, state_name, p->name,
                    p->parent ? p->parent->pid : -1, parent_state_name);
            found = 1;
          }
        }

            // Print all processes if no specific state or PID is specified
        if (state_t == -1 && pid_t == -1 && mstrcmp(name_t,"None")==1) {
            // Print the process information
          cprintf("pid: %d state: %s name: %s ppid: %d pstate: %s\n",
                  p->pid, state_name, p->name,
                  p->parent ? p->parent->pid : -1, parent_state_name);
          found = 1;
        }
    }

    // Additional search for close PIDs if no process found
    if (!found && pid_t != -1) {
        for (int i = 1; i < 6; i++) {
          for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
              if (p->state == UNUSED) continue; // Skip UNUSED processes

              if ((pid_t - p->pid) == i || (p->pid - pid_t) == i) {
                  // Map the process state to its string representation
                  switch (p->state) {
                      case UNUSED:   state_name = "UNUSED";   break;
                      case EMBRYO:   state_name = "EMBRYO";   break;
                      case SLEEPING: state_name = "SLEEPING"; break;
                      case RUNNABLE: state_name = "RUNNABLE"; break;
                      case RUNNING:  state_name = "RUNNING";  break;
                      case ZOMBIE:   state_name = "ZOMBIE";   break;
                      default:       state_name = "UNKNOWN";  break;
                  }

                  // Map the parent process state to its string representation

      if (p->parent) {  // Ensure p->parent is not null
                            switch (p->parent->state) {
                                case UNUSED:   parent_state_name = "UNUSED";   break;
                                case EMBRYO:   parent_state_name = "EMBRYO";break;
                                case SLEEPING: parent_state_name = "SLEEPING"; break;
                                case RUNNABLE: parent_state_name = "RUNNABLE"; break;
                                case RUNNING:  parent_state_name = "RUNNING";  break;
                                case ZOMBIE:   parent_state_name = "ZOMBIE";   break;
                                default:       parent_state_name = "UNKNOWN";  break;
                            }
                        } else {
                            parent_state_name = "N/A";
                        }

                        // Print the process information
                        cprintf("pid: %d state: %s name: %s ppid: %d pstate: %s\n",
                                p->pid, state_name, p->name,
                                p->parent ? p->parent->pid : -1, parent_state_name);
                        return 0;
                    }
                }
              }
          }

          return 0;
}
