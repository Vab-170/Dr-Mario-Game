check_match:
    # Calculate the base address of the starting pixel
    mul $t0, $a1, $a3
    add $t0, $t0, $a2
    add $t0, $t0, $a0
    lb $t1, 0($t0)
    
    # Check the next three pixels
    lb $t2, 1($t0)
    bne $t1, $t2, NoMatch
    lb $t3, 2($t0)
    bne $t1, $t3, NoMatch
    lb $t4, 3($t0)
    bne $t1, $t4, NoMatch
    
    # If all four match, return 1
    jal match
    
NoMatch:
    jr   $ra 

match:
    li $t0, 0x320000
    la $t1, score
    add $t1, $t1, $t0 
    sw $t1, score