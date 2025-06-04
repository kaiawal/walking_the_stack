#include <stdio.h>

#include "debug.h"

char const *regnames[] = {
    "rax",
    "rbx",
    "rcx",
    "rdx",
    "rsi",
    "rdi",
    "rbp",
    "rsp",
    "r8",
    "r9",
    "r10",
    "r11",
    "r12",
    "r13",
    "r14",
    "r15",
};

/* Internal helper function */
void
_debug_dump_registers(long const *regs)
{
    // example printing method:
    // "%s\t%ld (0x%lx)\n"    <register name>, <register value>, <register value (hex)>  
    for (int i = 0; i < 16; i++) {
        // prints name of register than prints register in decimal, hexidecimal
        printf("%s\t%ld (0x%lx)\n", regnames[i], regs[i], regs[i]);
    }
}
