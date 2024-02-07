#Laboratory Exercise 7 Home Assignment 1 
.data
a1: .asciiz "The abs of "
a2: .asciiz " is "
.text 
main: 
	li $a0, -45 		#load input parameter 
	add $a1,$zero,$a0
 	jal abs 		#jump and link to abs procedure 
 	nop 
 	add $s0, $zero, $v0 
 	li $v0, 4
 	la $a0, a1
    	syscall 
    	li $v0, 1
    	move $a0, $a1
    	syscall
    	li $v0, 4
    	la $a0, a2
    	syscall	
    	li $v0, 1
    	move $a0, $s0
    	syscall			
 	li $v0, 10 		#terminate 
 	syscall 
endmain: 
#-------------------------------------------------------------------- 
# function abs 
# param[in] $a0 the interger need to be gained the absolute value
# return $v0 absolute value 
#-------------------------------------------------------------------- 
abs: 
	sub $v0,$zero,$a0 	#put -(a0) in v0; in case (a0)<0 
 
 	bltz $a0,done 		#if (a0)<0 then done 
 	nop 
 	add $v0,$a0,$zero 	#else put (a0) in v0 
done: 
 	jr $ra