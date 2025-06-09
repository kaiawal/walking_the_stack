#ifndef DEBUG_H
#define DEBUG_H
extern void dump_registers(void);
extern void dump_backtrace(void);
void print_backtrace(long depth, void *addr);
#endif
