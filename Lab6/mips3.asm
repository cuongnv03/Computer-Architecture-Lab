.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word 
Message: .asciiz "\n"
Message1: .asciiz " "
.text
main: 	la $a0,A 		#$a0 = Address(A[0])
 	la $a1,Aend
 	addi $a1,$a1,-4 	#$a1 = Address(A[n-1])
 	j sort 			#sort
after_sort: 
	li $v0, 10 		#exit
 	syscall
end_main:

sort: 
	slt $s4,$a0,$a1
	beq $s4,$zero,done 	#single element list is sorted
 	j loop1 		
after_loop:
 	addi $a1,$a1,-4 	#decrement pointer to last element
 	la $t0,A
 	la $t1,Aend
print:	
	lw $at,0($t0)
	li $v0, 1 		# service 1 is print integer
 	move $a0, $at 		
 	syscall 		# execute
 	li $v0, 4
 	la $a0, Message1
 	syscall
 	addi $t0,$t0,4
 	slt $t3,$t0,$t1
 	bne $t3,$zero,print
 	li $v0, 4
 	la $a0, Message
 	syscall
 	la $a0,A 		#$a0 = Address(A[0])
 	j sort 			#repeat sort for smaller list
done: 	j after_sort

loop1:
	addi $v0,$a0,0 		#init pointer to first element
	lw $v1,0($v0) 		#init value to first value
	addi $t0,$a0,0 		#init next pointer to first
loop:
	beq $t0,$a1,ret 	#if next=last, return
	addi $t0,$t0,4 		#advance to next element
	lw $t1,0($t0) 		#load next element into $t1
	addi $s0,$v0,0
	addi $s1,$v1,0
	addi $v0,$t0,0 		#next element is new current element
	addi $v1,$t1,0 		#next value is new current value
	slt $t2,$s1,$t1 	#(current)< (next) ?
	bne $t2,$zero,loop 	#if (current)<(next), repeat
	lw $s3,0($t0) 		#
 	sw $s3,0($s0) 		#
 	sw $s1,0($t0) 		#swap 2 elements
 	addi $v1,$s1,0
	j loop 			#change completed; now repeat
ret:
	j after_loop
