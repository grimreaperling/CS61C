.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw ra, 28(sp)
    mv s0, a0
    mv s1, a1
    mv s2, a2

    mv a1, s0
    addi a2, x0, 0
    jal fopen
    addi t0, x0, -1
    bne a0, t0, next
    addi a1, x0, 50
    jal ra, exit2

next:
    mv s5, a0

    mv a1, s5
    mv a2, s1
    addi a3, x0, 4
    jal fread
    addi t0, x0, 4
    beq a0, t0, next2
    addi a1, x0, 51
    jal exit2
next2:
    lw s3, 0(s1) 

    mv a1, s5
    mv a2, s2
    addi a3, x0, 4
    jal fread
    addi t0, x0, 4
    beq a0, t0, next3
    addi a1, x0, 51
    jal exit2
next3:
    lw s4, 0(s2)

    mul s6, s3, s4
    mv a0, s6

    # Malloc the memory we read in the matrix.
    addi t0, x0, 4
    mul a0, s6, t0
    jal malloc
    add s3, a0, x0
    add s4, a0, x0

loop_start:
    mv a1, s5
    mv a2, s3
    addi a3, x0, 4
    jal ra, fread
    addi t0, x0, 4
    beq a0, t0, next4
    addi a1, x0, 51
    jal exit2
next4:
    addi s3, s3, 4
    addi s6, s6, -1
    bnez s6, loop_start

loop_end:
    mv a1, s5
    jal ra, fclose
    beqz a0, next5
    addi a1, x0, 52
    jal exit2
next5:
    mv a0, s4
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    ret
