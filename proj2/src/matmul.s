.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:
    addi sp, sp, -36
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    add s0, a0, x0
    add s1, a1, x0
    add s2, a2, x0
    add s3, a3, x0
    add s4, a4, x0
    add s5, x0, x0
    add s6, x0, x0
    add s7, a3, x0
    add s8, a6, x0

    # Error checks
    addi t0, x0, 1
    bge s1, t0, next1
    addi a1, x0, 2
    jal exit2
next1:
    bge s3, t0, next2
    addi a1, x0, 2
    jal exit2
next2:
    bge s4, t0, next3
    addi a1, x0, 3
    jal exit2
next3:
    beq s2, s4, outer_loop_start
    addi a1, x0, 4
    jal exit2

outer_loop_start:
    add a0, s0, x0
    add a2, s2, x0
    addi a3, x0, 1
    add a4, a5, x0

inner_loop_start:
    add a1, s3, x0
    
    addi sp, sp, -32
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)
    sw ra, 28(sp)

    jal ra, dot

    sw a0, 0(s8)

    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32 

    addi s6, s6, 1
    addi s3, s3, 4
    addi s8, s8, 4
    blt s6, a5, inner_loop_start

inner_loop_end:
    addi t0, x0, 4
    mul t0, s2, t0
    add s0, s0, t0
    add s6, x0, x0
    add s3, s7, x0
    addi s5, s5, 1
    blt s5, s1, outer_loop_start

outer_loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw s8, 32(sp)
    addi sp, sp, 36
    ret
