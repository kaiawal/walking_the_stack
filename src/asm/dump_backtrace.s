.extern print_backtrace
.globl dump_backtrace
.type dump_backtrace, @function
dump_backtrace:
    push %rbp 
    mov %rsp, %rbp
    push %rbx  # Save rbx since we'll use it
    push %rcx  # Save rcx for depth counter
    
    # Ensure 16-byte stack alignment
    # We've pushed 3 values (24 bytes), need 8 more for 32-byte alignment
    sub $8, %rsp

    # Get the frame pointer from caller's caller
    # Start with our caller's frame
    mov 0(%rbp), %rbx  # rbx = caller's frame pointer
    mov $0, %rcx       # depth counter

loop:
    # Basic sanity checks
    test %rbx, %rbx
    jz done
    
    # Simple bounds check - frame pointer should be reasonable
    cmp %rsp, %rbx
    jbe done  # If frame pointer <= stack pointer, something's wrong
    
    # Get return address
    mov 8(%rbx), %rax
    test %rax, %rax
    jz done

    # Call print_backtrace(depth, address)
    # Stack is now 16-byte aligned
    mov %rcx, %rdi     # first arg: depth  
    mov %rax, %rsi     # second arg: address
    call print_backtrace

    # Move to next frame
    mov 0(%rbx), %rbx
    inc %rcx
    
    # Prevent infinite loops
    cmp $50, %rcx
    jl loop

done:
    # Restore stack alignment
    add $8, %rsp
    pop %rcx
    pop %rbx
    pop %rbp
    ret

/*
dump_backtrace:
    push %rbp 
    mov %rsp, %rbp # save stack pointer

    mov %rbp, %rax # using rax to traverse
    mov $0, %rcx

main_loop:
    test %rax, %rax # if pointer is NULL
    jz exit

    mov 8(%rax), %rdx # rdx = function return address

    test %rdx, %rdx
    jz exit # if rdx is 0 end

    mov %rcx, %rdi   # arg1: depth
    mov %rdx, %rsi   # arg2: address
    call print_backtrace

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

*/