.import ../../src/argmax.s
.import ../../src/utils.s

.data
v0: .word 464 0 -365 3643 464 0 53629 886 -6015 464 # MAKE CHANGES HERE

.text
main:
    # Load address of v0
    la s0 v0
    
    # Set length of v0
    addi s1 x0 10 # MAKE CHANGES HERE

    # Call argmax
    mv a0 s0
    mv a1 s1
    jal ra argmax

    # Print the output of argmax
    mv a1 a0
    jal ra print_int

    # Print newline
    li a1 '\n'
    jal ra print_char

    # Exit program
    jal exit
