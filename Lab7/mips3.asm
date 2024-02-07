#Laboratory Exercise 7, Home Assignment 3 
.data
a1: .asciiz " "
.text
main: 
	li $s0,2 	#load test input 
 	li $s1,6 
push: 
	addi $sp,$sp,-8 	#adjust the stack pointer 
 	sw $s0,4($sp) 		#push $s0 to stack 
 	sw $s1,0($sp) 		#push $s1 to stack 
 	j pop
work: 
	li $v0, 1
    	move $a0, $s0
    	syscall
	li $v0, 4
 	la $a0, a1
    	syscall 
    	li $v0, 1
    	move $a0, $s1
    	syscall			
 	li $v0, 10 		#terminate 
 	syscall
	 
pop: 
	lw $s0,0($sp) 		#pop from stack to $s0 
 	lw $s1,4($sp) 		#pop from stack to $s1 
 	addi $sp,$sp,8 		#adjust the stack pointer 
 	j work
