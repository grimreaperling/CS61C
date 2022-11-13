.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -36
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw ra, 32(sp)
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    
    # Malloc a memory and put the row number and column number to it
    addi a0, x0, 8
    jal ra, malloc
    mv s5, a0
    sw s2, 0(s5)
    sw s3, 4(s5)
   
    mv a1, s0
    addi a2, x0, 1
    jal ra, fopen
    addi t0, x0, -1
    bne a0, t0, next
    addi a1, x0, 53
    jal exit2

next:
    mv s4, a0     # s4 save the filedescriptor for the file to write

    # Put the argument of the fwrite into the register.
    mv a1, s4
    mv a2, s5
    addi a3, x0, 2
    add s6, a3, x0
    addi a4, x0, 4
    jal ra, fwrite
    beq s6, a0, next2
    addi a1, x0, 54
    jal exit2

next2:
    # Free up the memory we setup for the row and column numbers
    mv a0, s5
    jal free

    mv a1, s4
    mv a2, s1
    mul t0, s2, s3
    add a3, x0, t0
    add s7, a3, x0
    addi a4, x0, 4
    jal ra, fwrite
    beq s7, a0, next3
    addi a1, x0, 54
    jal exit2
    
next3:
    mv a1, s4
    jal fclose
    beqz a0, next4
    addi a1, x0, 55
    jal exit2

next4:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw ra, 32(sp)
    addi sp, sp, 36
    ret
