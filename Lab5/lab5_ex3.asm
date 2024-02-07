#Laboratory Exercise 5, Home Assignment 2
.data
x: .space 32 			# destination string x, empty
y: .asciiz "Hello! This is Assignment 3 of Laboratory Week 5." 		# source string y
.text
init: 
	la $a1,y		#load address of y[0] to $a1
	la $a0,x		#load address of x[0] to $a0
strcpy:
	add $s0,$zero,$zero 	# $s0 = i = 0
L1:
	add $t1,$s0,$a1 	# $t1 = $s0 + $a1 = i + y[0]
 				# = address of y[i]
	lb $t2,0($t1) 		# $t2 = value at $t1 = y[i]
	add $t3,$s0,$a0 	# $t3 = $s0 + $a0 = i + x[0] 
 				# = address of x[i]
	sb $t2,0($t3) 		# x[i]= $t2 = y[i]
	beq $t2,$zero,end_of_strcpy # if y[i] == 0, exit
	nop
	addi $s0,$s0,1 		# $s0 = $s0 + 1 <-> i = i + 1
	j L1 			# next character
	nop
end_of_strcpy:
	li $v0, 4			# system call code to print string from ax
    	la $a0, x
    	syscall 			# call operating system to perform operation
