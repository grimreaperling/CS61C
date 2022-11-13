.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
    addi sp, sp, -52
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    sw s9, 36(sp)  # this register save the address of the final result of the matrix multiply.
    sw s10, 40(sp) # save the result
    sw s11, 44(sp)
    sw ra, 48(sp)
    mv s0, a0
    mv s1, a1
    mv s2, a2


	# =====================================
    # LOAD MATRICES
    # =====================================
    addi t0, x0, 5
    beq t0, s0, next
    addi a1, x0, 49
    jal exit2

    next:
    lw s3, 4(s1)  # Load the address of the first matrix path into s3 register.
    lw s4, 8(s1)     
    lw s5, 12(s1)
    lw s6, 16(s1)

    # Load pretrained m0
    addi a0, x0, 4
    jal malloc 
    mv t0, a0

    addi a0, x0, 4
    addi sp, sp, -4
    sw t0, 0(sp)
    jal malloc 
    lw t0, 0(sp)
    addi sp, sp, 4
    mv t1, a0

    mv a0, s3
    mv a1, t0
    mv a2, t1
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    jal read_matrix
    lw t0, 0(sp)
    lw t1, 4(sp)
    addi sp, sp, 8
    mv s3, a0

    # Load pretrained m1

    addi a0, x0, 4
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    jal malloc 
    lw t0, 0(sp)
    lw t1, 4(sp)
    addi sp, sp, 8
    mv t2, a0

    addi a0, x0, 4
    addi sp, sp, -12
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    jal malloc 
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    addi sp, sp, 12
    mv t3, a0

    mv a0, s4
    mv a1, t2
    mv a2, t3
    addi sp, sp, -20
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    jal read_matrix
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    addi sp, sp, 20
    mv s4, a0

    # Load input matrix

    addi a0, x0, 4
    addi sp, sp, -16
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    jal malloc 
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    addi sp, sp, 16
    mv t4, a0

    addi a0, x0, 4
    addi sp, sp, -20
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    jal malloc 
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    addi sp, sp, 20
    mv t5, a0

    mv a0, s5
    mv a1, t4
    mv a2, t5
    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    jal read_matrix
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24
    mv s5, a0

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    lw s0, 0(t0)
    lw s1, 0(t5)
    mul s1, s0, s1
    mv s8, s1
    addi s0, x0, 4
    mul s1, s0, s1

    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    mv a0, s1   
    jal malloc
    mv s7, a0   # Save the address of the destine matrix in the register s7
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24 

    mv a0, s3
    lw a1, 0(t0)
    lw a2, 0(t1)
    mv a3, s5
    lw a4, 0(t4)
    lw a5, 0(t5)
    mv a6, s7
    
    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    jal matmul
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24

    mv a0, s7
    mv a1, s8
    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    jal relu
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24

    # The second multiply.
    lw s0, 0(t2)
    lw s1, 0(t5)
    mul s1, s0, s1
    mv s8, s1
    addi s0, x0, 4
    mul s1, s1, s0

    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    mv a0, s1   
    jal malloc
    mv s9, a0   # Save the address of the destine matrix in the register s9
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24 

    mv a0, s4
    lw a1, 0(t2)
    lw a2, 0(t3)
    mv a3, s7
    lw a4, 0(t0)
    lw a5, 0(t5)
    mv a6, s9

    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    jal matmul
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    mv a0, s6        
    mv a1, s9
    lw a2, 0(t2)
    lw a3, 0(t5)

    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    jal write_matrix
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24
    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0, s9
    mv a1, s8
    addi sp, sp, -24
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    jal argmax
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    addi sp, sp, 24
    mv s10, a0

    # Free all the memory
    addi sp, sp, -20
    sw t1, 0(sp)
    sw t2, 4(sp)
    sw t3, 8(sp)
    sw t4, 12(sp)
    sw t5, 16(sp)
    mv a0, t0
    jal free
    lw t1, 0(sp)
    lw t2, 4(sp)
    lw t3, 8(sp)
    lw t4, 12(sp)
    lw t5, 16(sp)
    addi sp, sp, 20
     
    addi sp, sp, -16
    sw t2, 0(sp)
    sw t3, 4(sp)
    sw t4, 8(sp)
    sw t5, 12(sp)
    mv a0, t1
    jal free
    lw t2, 4(sp)
    lw t3, 8(sp)
    lw t4, 12(sp)
    lw t5, 16(sp)
    addi sp, sp, 16

    addi sp, sp, -12
    sw t3, 0(sp)
    sw t4, 4(sp)
    sw t5, 8(sp)
    mv a0, t2
    jal free
    lw t3, 0(sp)
    lw t4, 4(sp)
    lw t5, 8(sp)
    addi sp, sp, 12

    addi sp, sp, -8
    sw t4, 0(sp)
    sw t5, 4(sp)
    mv a0, t3
    jal free
    lw t4, 0(sp)
    lw t5, 4(sp)
    addi sp, sp, 8

    addi sp, sp, -4
    sw t5, 0(sp)
    mv a0, t4
    jal free
    lw t5, 0(sp)
    addi sp, sp, 4

    mv a0, t5
    jal free

    mv a0, s7
    jal free
    mv a0, s9
    jal free
    # Print classification
    bnez s2, end
    mv a1, s10    
    jal ra, print_int

    # Print newline afterwards for clarity
    li a1, '\n'
    jal ra, print_char

end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw s8, 32(sp)
    lw s9, 36(sp)  # this register save the address of the final result of the matrix multiply.
    lw s10, 40(sp) # save the result
    lw s11, 44(sp)
    lw ra, 48(sp)
    addi sp, sp, 52
    ret
