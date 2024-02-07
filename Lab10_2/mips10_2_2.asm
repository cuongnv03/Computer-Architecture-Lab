.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
# Auto clear after sw
.text
li $k0, KEY_CODE
li $k1, KEY_READY
li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY
li $s2, 0 # count the command characters entered correctly
loop: nop
beq $s2, 4, Exit
WaitForKey: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE


CheckCmd:
beq $s2, 0, FirstChar
beq $s2, 1, SecondChar
beq $s2, 2, ThirdChar
beq $s2, 3, FourthChar
FirstChar:
bne $t0, 'e', NotCmd
addi $s2, $s2, 1
j WaitForDis

SecondChar:
bne $t0, 'x', NotCmd
addi $s2, $s2, 1
j WaitForDis

ThirdChar:
bne $t0, 'i', NotCmd
addi $s2, $s2, 1
j WaitForDis

FourthChar:
bne $t0, 't', NotCmd
addi $s2, $s2, 1
j WaitForDis

NotCmd:
li $s2, 0

WaitForDis: 
lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling

ChangeChar:
ble $t0, '9', numberChar
ble $t0, 'Z', upperChar
ble $t0, 'z', lowerChar
j ChangeToStar

numberChar:
blt $t0, '0', ChangeToStar
j ShowKey

upperChar:
blt $t0, 'A', ChangeToStar
addi $t0, $t0, 32
j ShowKey

lowerChar:
blt $t0, 'a', ChangeToStar
addi $t0, $t0, -32
j ShowKey

ChangeToStar:
addi $t0, $zero, '*'



ShowKey: sw $t0, 0($s0) # show key
nop
j loop

Exit:
li $v0, 10
syscall
