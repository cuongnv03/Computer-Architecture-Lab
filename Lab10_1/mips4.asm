#.eqv MONITOR_SCREEN 0x10010000
.eqv WHITE 0x00FFFFFF
.data
MONITOR_SCREEN: .word 0x00FFFFFF
.text
    li $s0, 2
    li $t1, 0
    loop1:
    beq $t1, 8, end_loop1
    div $t1, $s0
    mfhi $t2
        loop2:
        bge $t2, 8, end_loop2
        mul $t3, $t1, 8
        add $t3, $t3, $t2
        sll $t3, $t3, 2
        li $t0, WHITE
        sw $t0, MONITOR_SCREEN($t3)
        addi $t2, $t2, 2
        j loop2
        end_loop2:
    addi $t1, $t1, 1
    j loop1
    end_loop1:
    li $v0, 10
    syscall