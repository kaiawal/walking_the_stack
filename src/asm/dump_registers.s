.extern _debug_dump_registers
.globl dump_registers
.type dump_registers, @function
dump_registers:
    push %rbp
    mov %rsp, %rbp # store rsp
    sub $8, %rsp 
    push %rax #push everything onto the stack
    push %rbx
    push %rcx
    push %rdx
    push %rsi
    push %rdi
    push %rbp
    lea 16(%rbp), %rax #reallign 
    push %rax
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

    add $(16*8 + 8), %rsp #realign
    pop %rbp
    ret #exit
