.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    bne a0, x0, next
    addi a0, x0, 1
    jr ra
next:
    add t0, x0, a0
    addi a0, a0, -1
    addi sp, sp, -8
    sw ra, 0(sp)
    sw t0, 4(sp)
    jal ra, factorial
    lw ra, 0(sp)
    lw t0, 4(sp)
    addi sp, sp, 8
    mul a0, a0, t0
    jr ra

    

    
