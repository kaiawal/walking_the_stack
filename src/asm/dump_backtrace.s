.globl dump_backtrace
.type dump_backtrace, @function
dump_backtrace:



.section .rodata
backtrace_format_str:
.asciz "%3ld: [%lx] %s () %s\n"


/*
dump_backtrace
.type dump_backtrace, @function
dump_backtrace:
    push %rbp
    mov %rsp, %rbp

    mov %rbp, %rax          # rax = current frame pointer
    mov $0, %rcx            # rcx = depth (counter)

.loop:
    mov 8(%rax), %rdx       # rdx = return address
    test %rdx, %rdx
    jz .done
    mov %rcx, %rdi          # 1st arg: depth
    mov %rdx, %rsi          # 2nd arg: return address
    call print_backtrace_entry
    mov (%rax), %rax        # rax = previous frame pointer
    inc %rcx                # depth++
    cmp $32, %rcx           # limit depth to 32
    jl .loop

.done:
    pop %rbp
    ret
*/

/* helper C function
void
_debug_dump_registers(long const *regs)
{
    for (int i = 0; i < 16; ++i) {
        printf("%s\t%ld (0x%lx)\n", regnames[i], regs[i], regs[i]);
    }
}
*/