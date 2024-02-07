.data
string: .space 20
reverse: .space 20
.text
get_string:
	li $v0, 8
	la $a0, string
	li $a1, 20
	syscall
get_length:
	la $a0, string # a0 = Address(string[0])
	li $v0, 0 # v0 = length = 0

check_char:
	add $t1,$a0,$t0 	# $t1 = $a0 + $t0
 				# = address(string[i]) 
 	lb $t2, 0($t1) 		# $t2 = string[i]
 	beq $t2, $zero, end_of_str # is null char? 
 	addi $t0, $t0, 1 	# $t0 = $t0 + 1 -> i = i + 1
 	j check_char
end_of_str:
end_of_get_length:
	add $t1,$a0,$t0
	li  $t2, 0            # counter i = 0
	li $v0, 11
reverseString:
        slt  $t3, $t2, $t0    # if i < stringlength
        beq  $t3, $0,  Exit  	# if t3 reaches he end of the array
        addi $t1, $t1, -1     # decrement the array 
        addi $t2,$t2,1
        lbu  $a0, 0($t1)      # load the array from the end
        syscall
        j reverseString
Exit:

