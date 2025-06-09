#define _GNU_SOURCE
#include <stdio.h>
#include <dlfcn.h>

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




void
_debug_dump_registers(long *const regs)
{
    // example printing method: 
    // "%s\t%ld (0x%lx)\n"    <register name>, <register value>, <register value (hex)>
    for (int i = 0; i < 16; i++) {
        // prints name of register than prints register in decimal, hexidecimal
        printf("%s\t%ld (0x%lx)\n", regnames[i], regs[i], regs[i]);
    }
}

// Helper function for dump_backtrace 
void print_backtrace(long depth, void *addr){
    // Declare Dl_info struct to hold information (symbol address, depth, symbol name, file name)
    Dl_info info;
    if (dladdr(addr, &info) && info.dli_sname && info.dli_fname) {
        // print depth, memory address, function name, file name
        // "%3ld: [%lx] %s () %s\n"    <depth>, <symbol address>, <symbol name>, <file name>
        printf("%3ld: [%lx] %s () %s\n", depth, (long)addr, info.dli_sname, info.dli_fname);
<<<<<<< HEAD
=======
    } else {
        printf("%3ld: [%lx] ??? () ???\n", depth, (unsigned long)addr);
>>>>>>> f58ab3ddda25bbafbfbde174df238999932794d1
    }
}
