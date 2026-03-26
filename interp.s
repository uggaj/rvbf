    .section .bss
buffer: .space 1000000
    
    .section .text
load:
    li a7, 56
    li a0, -100
    lw a1, 4(a1)
    li a2, 0
    li a3, 0
    ecall
    mv t0, a0
    li t3, 0
read:
    li a7, 63
    la a1, buffer
    add a1, a1, t3
    li a2, 1000000
    sub a2, a2, t3
    mv a0, t0
    ecall
    mv t1, a0
    add t3, t3, t1
    li t2, 0
    bne t1, t2, read
