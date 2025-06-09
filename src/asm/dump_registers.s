.extern _debug_dump_registers
.globl dump_registers
.type dump_registers, @function
dump_registers:
    subq $(16*8), %rsp
    movq %rsp, %rdi
    push %rax
    push %rbx
    push %rcx
    push %rdx
    push %rsi
    push %rdi
    push %rbp
    push %r8
    push %r9
    push %r10
    push %r11
    push %r12
    push %r13
    push %r14
    push %r15
    mov %rsp, %rdi
    call _debug_dump_registers
    addq $(15*8), %rsp
    ret
    