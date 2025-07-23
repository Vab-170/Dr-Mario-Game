score_disp:
    li $a1, 27
    li $a2, 3
    lw $t1, score
    jal draw_pixel
    
    li $a1, 28
    li $a2, 3
    jal draw_pixel
    jr $ra