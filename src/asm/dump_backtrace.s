.extern print_backtrace
.globl dump_backtrace
.type dump_backtrace, @function

dump_backtrace:
    push %rbp 
    mov %rsp, %rbp # save rsp

    push %rbx
    push %r12 
    sub $8, %rsp #realign stack
    mov %rbp, %rbx # rbx = fram pointer
    mov $0, %r12 # depth counter

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

