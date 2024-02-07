.data
MONITOR_SCREEN: .word 0x00FFFFFF

.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00

.text
	li $v0, 5
	syscall
	move $t1, $v0 #x1
	
	li $v0, 5
	syscall
	move $s1, $v0 #y1
	
	li $v0, 5
	syscall
	move $t2, $v0 #x2
	
	li $v0, 5
	syscall
	move $s2, $v0 #y2
	
	move $t3, $t1
	
	loop1:
	bgt $t3, $t2, end_loop1
	move $s3, $s1
		loop2:
		bgt $s3, $s2, end_loop2
		
		mul $t8, $t3, 128
		add $t8, $t8, $s3
		sll $t8, $t8, 2
		beq $t3, $t1, red
		beq $t3, $t2, red
		beq $s3, $s1, red
		beq $s3, $s2, red
		green:
		li $t0, GREEN, 
		end_green:
		j end_red
		red:
		li $t0, RED
		end_red:
		sw $t0, MONITOR_SCREEN($t8)
		addi $s3, $s3, 1
		j loop2
		end_loop2:
	addi $t3, $t3, 1
	j loop1
	end_loop1:
	
	