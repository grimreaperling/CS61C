.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    addi t0, x0, 1
    bge s1, t0, start
    addi a1, x0, 8
    jal ra, exit2
    
start:
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    add s0, a0, x0
    add s1, a1, x0 

loop_start:
    lw t0, 0(a0)
    bge t0, x0, loop_continue
    sw x0, 0(a0)

loop_continue:
    addi, a0, a0, 4 
    addi, a1, a1, -1 
    bne a1, x0, loop_start

loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
	ret
