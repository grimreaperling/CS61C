.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:
    # Error handle
    addi t0, x0, 1
    bge a2, t0, stride0
    addi a1, t0, 5
    jal ra, exit2
stride0: 
    bge a3, t0, stride1
    addi a1, t0, 6
    jal ra, exit2
stride1:
    bge a4, t0, start
    addi a1, t0, 6
    jal ra, exit2

start:
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    add s0, a0, x0
    add s1, x0, x0
    addi s2, x0, 4
    add a0, x0, x0


loop_start:
    mul t0, a3, s2
    mul t0, t0, s1
    add t0, t0, s0
    lw t0, 0(t0)

    mul t1, a4, s2
    mul t1, t1, s1
    add t1, t1, a1
    lw t1, 0(t1)

    mul t1, t0, t1
    add a0, a0, t1

    addi s1, s1, 1
    blt s1, a2, loop_start

loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret
