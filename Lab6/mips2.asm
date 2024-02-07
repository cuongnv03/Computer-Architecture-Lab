.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
Message: .asciiz "\n"
Message1: .asciiz " "
.text
main:	la $a0,A #$a0 = Address(A[0])
	la $s5,A #$s5 = Address(A[0])
	la $a1,Aend
 	addi $a1,$a1,-4 #$a1 = Address(A[n-1])
 	j sort #sort
after_sort: 
	li $v0, 10 #exit
 	syscall
end_main:

sort: 
	slt $s4,$a0,$a1
	beq $a0,$a1,done #single element list is sorted
	addi $a0,$a0,4
	addi $s6,$a0,0
 	j loop1
after_loop:
	la $t0,A
	la $t1,Aend
print:
	lw $at,0($t0)
	li $v0,1 	#service 1 is print integer
	move $a0,$at
	syscall		#execute
	li $v0, 4
	la $a0, Message1
	syscall
	addi $t0,$t0,4
	slt $t3,$t0,$t1
	bne $t3,$zero,print
	li $v0,4
	la $a0,Message
	syscall
	addi $a0,$s6,0	#$s6 = Address(A[i])
	j sort
done:	j after_sort
loop1:
	addi $v0,$a0,0	#init pointer to current element
	lw $v1,0($v0)	#init value to current value
	addi $t0,$a0,0	#init previous pointer to previous element
loop:
	beq $t0,$s5,ret 	#if next=last, return
	addi $t0,$t0,-4 	#advance to previous element
	lw $t1,0($t0) 		#load previous element into $t1
	addi $s0,$v0,0
	addi $s1,$v1,0
	addi $v0,$t0,0		#previous element is new current element
	addi $v1,$t1,0		#previous value is new current value
	slt $t2,$t1,$s1 	#(previous)<(current) ?
	bne $t2,$zero,loop 	#if (previous)<(current), repeat
	lw $s3,0($t0)
	sw $s3,0($s0)
	sw $s1,0($t0)		#swap 2 elements
	addi $v1,$s1,0 		
	j loop 			#change completed; now repeat
ret:
	j after_loop