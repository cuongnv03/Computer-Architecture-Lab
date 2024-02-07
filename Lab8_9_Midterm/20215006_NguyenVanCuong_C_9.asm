.data
input_prompt: .asciiz "Enter a string: "
output_prompt: .asciiz "Modified string: "
input_string: .space 100    # Allocate space for input string
output_string: .space 100   # Allocate space for output string

.text
main:
    # Print the input prompt and read the input string
    la $a0, input_prompt
    li $v0, 4
    syscall

    la $a0, input_string
    li $a1, 100
    li $v0, 8
    syscall

    # Call the capitalize_words function
    move $a0, $s0  # $a0: pointer to the input string
    move $a1, $s1  # $a1: pointer to the output string
    jal capitalize_words

    # Print the modified string
    la $a0, output_prompt
    li $v0, 4
    syscall

    la $a0, output_string
    li $v0, 4
    syscall

    # Exit the program
    li $v0, 10
    syscall

# Function to capitalize the first letter of each word in a string
# Inputs:
# $a0: pointer to the input string
# $a1: pointer to the output string
# Outputs:
# None
capitalize_words:
    addi $sp, $sp, -12         # allocate space for variables
    sw $ra, 0($sp)             # save return address
    sw $t0, 4($sp)             # save index
    sw $t1, 8($sp)             # save flag
    move $t0, $a0              # move string address to $t0
    li $t1, 1                  # set flag to 1 (capitalize next character)
    addi $a1, $zero, ' '       # set delimiter to space character
    
loop:
    sw $t0, ($t2)             # load next character into $t2
    beq $t2, $zero, end_loop   # if null character, exit loop
    beq $t1, $zero, skip       # if flag is 0, skip capitalization
    sub $t3, $t2, $a1          # subtract delimiter from character
    bne $t3, $zero, no_cap     # if character is not after delimiter, skip capitalization
    subi $t2, $t2, 32         # capitalize character (add 32 to ASCII value)
    sb $t0, ($t2)              # store capitalized character in string
    li $t1, 0                  # set flag to 0 (do not capitalize next character)
    j skip                     # jump to end of loop
    
no_cap:
    li $t1, 0                  # set flag to 0 (do not capitalize next character)
    
skip:
    addi $t0, $t0, 1           # increment index
    j loop                     # jump to beginning of loop
    
end_loop:
    lw $t1, 8($sp)             # restore flag
    lw $t0, 4($sp)             # restore index
    lw $ra, 0($sp)             # restore return address
    addi $sp, $sp, 12          # deallocate space for variables
    jr $ra                     # return
