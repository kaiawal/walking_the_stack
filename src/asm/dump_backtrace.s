.extern _debug_dump_registers
.globl dump_backtrace
.type dump_backtrace, @function
dump_backtrace:
    push %rbp 
    mov %rsp, %rbp # save stack pointer

    mov (%rbp), %rax # using rax to traverse
    mov $0, %rcx

main_loop:
    test %rax, %rax # if pointer is NULL
    jz exit

    mov 8(%rax), %rdx # rdx = function return address

    test %rdx, %rdx
    jz exit # if rdx is 0 end

    mov %rcx, %rdi   # arg1: depth
    mov %rdx, %rsi   # arg2: address
    call print_backtrace_entry

    mov (%rax), %rax # moving to previous pointer

    inc %rcx
    cmp $100, %rcx # to account for infinite loop
    jge exit

    jmp main_loop

exit:
    pop %rbp
    ret


.section .rodata
backtrace_format_str:
.asciz "%3ld: [%lx] %s () %s\n"

