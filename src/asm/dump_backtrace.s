.extern print_backtrace
.globl dump_backtrace
.type dump_backtrace, @function

dump_backtrace:
    push %rbp 
<<<<<<< HEAD
    mov %rsp, %rbp # save rsp

    push %rbx
    push %r12 
    sub $8, %rsp #realign stack
    mov %rbp, %rbx # rbx = fram pointer
    mov $0, %r12 # depth counter
=======
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
>>>>>>> c4e036f5eb417423e64e5ba2513300c3be3f174a

loop:
    test %rbx, %rbx
    jz done # if rbx = 0

    test $0x7, %rbx 
    jnz done

    cmp %rsp, %rbx # making sure above stack and accessing good memory
    jbe done

    mov 8(%rbx), %rax # return address

    # setting up function call
    mov %r12, %rdi # arg1 depth
    mov %rax, %rsi # arg2 return address
    push %rbx 
    push %r12 #saving rbx and r12 
    call print_backtrace
    pop %r12
    pop %rbx 

next_frame:
    mov 0(%rbx), %rbx #get previous pointer
    inc %r12
    cmp $8, %r12 # cut off at 8 so no infinite loop
    jl loop

done:
    add $8, %rsp #restore stack
    pop %r12
    pop %rbx
    pop %rbp
    ret # exit!! and its done

*/
