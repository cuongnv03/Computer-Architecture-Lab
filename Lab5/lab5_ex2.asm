.data 		## Data declaration section
a1: .asciiz "The sum of "
a2: .asciiz " and "
a3: .asciiz " is "
.text 		## Assembly language instructions go in text segment
main: 		## Start of code section
    addi $s0,$zero,17		# s0 = 17
    addi $s1, $zero,15		# s1 = 15
    add $s2,$s0,$s1		# s2 = s0 + s1
    li $v0, 4			# system call code to print string from a1
    la $a0, a1
    syscall 			# call operating system to perform operation
    li $v0, 1			# system call code to print integer from $s0
    move $a0, $s0
    syscall 			# call operating system to perform operation
    li $v0, 4			# system call code to print string from a2
    la $a0, a2
    syscall
    li $v0, 1			# system call code to print integer from $s1
    move $a0, $s1	
    syscall 			# call operating system to perform operation
    li $v0, 4			# system call code to print string from a3
    la $a0, a3
    syscall
    li $v0, 1			# system call code to print integer from $s2
    move $a0, $s2
    syscall
