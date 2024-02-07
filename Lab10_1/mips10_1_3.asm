#Laboratory Exercise 10.1, Assignment 3
.eqv SEVENSEG_LEFT    0xFFFF0011    # Address of led 7 (left)
				#  Bit0=doana; 
				# Bit1=doanb;... 
				# Bit7=dau.                             
.eqv SEVENSEG_RIGHT   0xFFFF0010    # Address of led 7 (right)

.text 
main:
	li $v0, 12
	syscall # nhap so
	
	
	
	div $v0, $v0, 100
	mfhi $a1
	
	div $a1, $a1, 10
	
	mflo    $s1	# set value for segments
	jal CHECK
	jal   SHOW_7SEG_LEFT	# show
	
	mfhi    $s1	# set value for segments
	jal CHECK
	jal   SHOW_7SEG_RIGHT	# show
exit:	
	li    $v0, 10
	syscall

endmain:

#-------------------------------------check number--------------

CHECK:

	beq $s1, 0, case_0
	beq $s1, 1, case_1
	beq $s1, 2, case_2
	beq $s1, 3, case_3
	beq $s1, 4, case_4
	beq $s1, 5, case_5
	beq $s1, 6, case_6
	beq $s1, 7, case_7
	beq $s1, 8, case_8
	beq $s1, 9, case_9

case_0:
	li $a0, 0x3f
	j end_check
case_1:
	li $a0, 0x06
	j end_check	
case_2:
	li $a0, 0x5b
	j end_check
case_3:
	li $a0, 0x4f
	j end_check
case_4:
	li $a0, 0x66
	j end_check
case_5:
	li $a0, 0x6d
	j end_check
case_6:
	li $a0, 0x7d
	j end_check
case_7:
	li $a0, 0x07
	j end_check
case_8:
	li $a0, 0x7f
	j end_check
case_9:
	li $a0, 0x6f
	j end_check
end_check:
	jr $ra

#--------------------------------------------------------------- 
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address
                 sb   $a0,  0($t0)        # assign new value
                 jr   $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # assign port's address
                 sb   $a0,  0($t0)         # assign new value
		jr $ra
