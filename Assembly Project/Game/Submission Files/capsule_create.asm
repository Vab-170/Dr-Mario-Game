draw_pixel:
# Registers Used in function:
# $t2 - holds the address of the display
# $a1 - holds the column
# $a2 - holds the row
    lw $t2, ADDR_DSPL
    
    mul $t4, $a2, 32
    add $t5, $t4, $a1
    sll $t5, $t5, 2

    add $t6, $t2, $t5
    sw $t1, 0($t6)

    jr $ra

load_capsule:
    # Save return address
    move $a3, $ra
    
    li $a1, 5
    jal random_in_range
    
    move $ra, $a3
    
    # spawn a different capsule based on the randomly generated number
    
    li $t0, 0
    beq $a0, $t0, R_R_R
    li $t0, 1
    beq $a0, $t0, R_R_B 
    li $t0, 2
    beq $a0, $t0, R_R_Y 
    li $t0, 3
    beq $a0, $t0, B_R_B 
    li $t0, 4
    beq $a0, $t0, Y_R_Y 
    li $t0, 5
    beq $a0, $t0, R_R_Y
    
R_R_R:
    # Save return address
    move $s6, $ra

    # Load first pixel position
    lb $a1, pixel1_x       # Load address of pixel1_x
    lb $a2, pixel1_y       # Load address of pixel1_y
    
    lw $t1, red_col
    sw $t1, capsule_color1

    jal draw_pixel          # Draw pixel to screen
    
    # Load second pixel position
    lb $a1, pixel2_x      # Load address of pixel2_x
    lb $a2, pixel2_y      # Load address of pixel2_y
    
    sw $t1, capsule_color2

    jal draw_pixel          # Draw pixel to screen
    
    move $ra, $s6
    jr $ra
    
R_R_B:
    # Save return address
    move $s6, $ra

    # Load first pixel position
    lb $a1, pixel1_x       # Load address of pixel1_x
    lb $a2, pixel1_y       # Load address of pixel1_y
    
    lw $t1, red_col
    sw $t1, capsule_color1
    
    jal draw_pixel          # Draw pixel to screen
    
    # Load second pixel position
    lb $a1, pixel2_x      # Load address of pixel2_x
    lb $a2, pixel2_y      # Load address of pixel2_y

    lw $t1, blue_col
    sw $t1, capsule_color2

    jal draw_pixel          # Draw pixel to screen

    move $ra, $s6
    jr $ra
    
R_R_Y:
    # Save return address
    move $s6, $ra

    # Load first pixel position
    lb $a1, pixel1_x       # Load address of pixel1_x
    lb $a2, pixel1_y       # Load address of pixel1_y
    
    lw $t1, red_col
    sw $t1, capsule_color1

    jal draw_pixel          # Draw pixel to screen
    
    # Load second pixel position
    lb $a1, pixel2_x      # Load address of pixel2_x
    lb $a2, pixel2_y      # Load address of pixel2_y

    lw $t1, yellow_col
    sw $t1, capsule_color2
    
    jal draw_pixel          # Draw pixel to screen

    move $ra, $s6
    jr $ra
    
B_R_B:
    # Save return address
    move $s6, $ra

    # Load first pixel position
    lb $a1, pixel1_x       # Load address of pixel1_x
    lb $a2, pixel1_y       # Load address of pixel1_y
    
    lw $t1, blue_col
    sw $t1, capsule_color1

    jal draw_pixel          # Draw pixel to screen
    
    # Load second pixel position
    lb $a1, pixel2_x      # Load address of pixel2_x
    lb $a2, pixel2_y      # Load address of pixel2_y
    
    sw $t1, capsule_color2
    
    jal draw_pixel          # Draw pixel to screen

    move $ra, $s6
    jr $ra
    
Y_R_Y:
    # Save return address
    move $s6, $ra

    # Load first pixel position
    lb $a1, pixel1_x       # Load address of pixel1_x
    lb $a2, pixel1_y       # Load address of pixel1_y
    
    lw $t1, yellow_col
    sw $t1, capsule_color1

    jal draw_pixel          # Draw pixel to screen
    
    # Load second pixel position
    lb $a1, pixel2_x      # Load address of pixel2_x
    lb $a2, pixel2_y      # Load address of pixel2_y
    
    sw $t1, capsule_color2
    
    jal draw_pixel          # Draw pixel to screen

    move $ra, $s6
    jr $ra
    
B_R_Y:
    # Save return address
    move $s6, $ra

    # Load first pixel position
    lb $a1, pixel1_x       # Load address of pixel1_x
    lb $a2, pixel1_y       # Load address of pixel1_y
    
    lw $t1, blue_col
    sw $t1, capsule_color1

    jal draw_pixel          # Draw pixel to screen
    
    # Load second pixel position
    lb $a1, pixel2_x      # Load address of pixel2_x
    lb $a2, pixel2_y      # Load address of pixel2_y

    lw $t1, yellow_col
    sw $t1, capsule_color2
    
    jal draw_pixel          # Draw pixel to screen

    move $ra, $s6
    jr $ra