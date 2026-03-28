    .section .bss
buffer: .space 1000000
tape:   .space 30000
    
    .section .text
load:
    li a7, 56
    li a0, -100
    lw a1, 8(sp)
    li a2, 0
    li a3, 0
    ecall
    mv s1, a0
    li s2, 0
    jr ra
read:
    li a7, 63
    la a1, buffer
    add a1, a1, s2
    li a2, 1000000
    sub a2, a2, s2
    mv a0, s1
    ecall
    mv t1, a0
    add s2, s2, t1
    bne t1, x0, read
    la a1, buffer
    add s4, a1, s2
    jr ra
incr:
    lb t0, 0(s3)
    addi t0, t0, 1
    sb t0, 0(s3)
    addi s2, s2, 1
    j interp
decr:
    lb t0, 0(s3)
    addi t0, t0, -1
    sb t0, 0(s3)
    addi s2, s2, 1
    j interp
frwd:
    addi s3, s3, 1
    addi s2, s2, 1
    j interp
brwd:
    li t1, 1
    sub s3, s3, t1
    addi s2, s2, 1
    j interp
print:
    li a0, 1
    mv a1, s3
    li a2, 1
    li a7, 64
    ecall
    addi s2, s2, 1
    j interp
exit:
    li a7, 93
    li a0, 0
    ecall
interp:
    beq s2, s4, exit
    lb t1, 0(s2)
    li t0, '+'
    beq t1, t0, incr
    li t0, '-'
    beq t1, t0, decr
    li t0, '>'
    beq t1, t0, frwd
    li t0, '<'
    beq t1, t0, brwd
    li t0, '.'
    beq t1, t0, print
    addi s2, s2, 1
    j interp

    .globl _start
_start:
    jal ra, load
    jal ra, read
    la s2, buffer
    la s3, tape
    j interp
