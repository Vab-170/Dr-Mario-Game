random_in_range:
    li $v0, 42
    move $t8, $a0
    li $a0, 0
    
    syscall
    
    jr $ra