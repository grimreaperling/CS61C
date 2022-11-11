.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:
    addi t0, x0, 1
    bge a1, t0, start
    addi a1, x0, 7
    jal ra, exit2

start:
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    add s0, a0, x0
    add s1, x0, x0
    lw t0, 0(s0)
    add s2, t0, x0
    add a0, x0, x0

loop_start:
    lw t0, 0(s0)
    blt t0, a1 loop_continue
    add s2, t0, x0
    add a0, s1, x0

loop_continue:
    addi, s0, s0, 4
    addi, s1, s1, 1
    bne s1, a1, loop_start

loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret
