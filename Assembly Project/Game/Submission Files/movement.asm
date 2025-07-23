key_check:
    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    beq $t8, 1, keyboard_input      # If first word 1, key is pressed
    
    jr  $ra
    
keyboard_input:                     # A key is pressed
    lw $a0, 4($t0)                  # Load second word from keyboard
    beq $a0, 0x71, quit_game        # Check if the key q was pressed
    beq $a0, 0x70, pause_loop       # Check if the key p was pressed
    beq $a0, 0x77, rotate_capsule   # Check if the key w was pressed
    beq $a0, 0x73, move_down        # Check if the key s was pressed
    beq $a0, 0x61, move_left        # Check if the key a was pressed
    beq $a0, 0x64, move_right       # Check if the key d was pressed

    j key_check
    
quit_game:
    li $a0, 88
    li $a1, 1000
    li $a2, 0
    li $a3, 128
    li $v0, 31
    syscall
    li $v0, 10
    syscall

pause_loop:
    lw $a0, 4($t0)
    bne $a0, 0x70, key_check
    j pause_loop
    
    # Exit pause when a key is detected
check_exit:
    jr $ra                   # Return
    
# Function to scan the grid and check if the positions of both pixels are occupied
check_move0:
    lb $t0, pixel1_x        # Load pixel1_x into $t0
    lb $t1, pixel1_y        # Load pixel1_y into $t1
    lb $t2, pixel2_x        # Load pixel2_x into $t2
    lb $t3, pixel2_y        # Load pixel2_y into $t3

    # Grid parameters
    la $t4, grid
    li $t5, 32

    # Calculate the address of the grid cell
    mul $t6, $t1, $t5      # Row offset
    add $t6, $t6, $t0      # Add column index
    add $t7, $t4, $t6      # Final grid cell addresszs
    lb $t8, 0($t7)

    # If value at grid location is not zero, pixel1 is occupied
    bnez $t8, end_move
    
    # Calculate the address of the grid cell
    mul $t6, $t3, $t5      # Row offset
    add $t6, $t6, $t2      # Add column index
    add $t7, $t4, $t6      # Final grid cell addresszs
    lb $t8, 0($t7)

    # If value at grid location is not zero, pixel2 is occupied
    bnez $t8, end_move

    # If both pixels are not occupied continue
    jr $ra
    
check_move1:
    lb $t0, pixel1_x        # Load pixel1_x into $t0
    lb $t1, pixel1_y        # Load pixel1_y into $t1

    # Grid parameters
    la $t4, grid
    li $t5, 32

    # Calculate the address of the grid cell
    mul $t6, $t1, $t5      # Row offset
    add $t6, $t6, $t0      # Add column index
    add $t7, $t4, $t6      # Final grid cell addresszs
    lb $t8, 0($t7)

    # If value at grid location is not zero, pixel1 is occupied
    bnez $t8, end_move
    
    # If pixel1 not occupied continue
    jr $ra
    
check_move2:
    lb $t2, pixel2_x        # Load pixel2_x into $t2
    lb $t3, pixel2_y        # Load pixel2_y into $t3

    # Grid parameters
    la $t4, grid
    li $t5, 32
    
    # Calculate the address of the grid cell
    mul $t6, $t3, $t5      # Row offset
    add $t6, $t6, $t2      # Add column index
    add $t7, $t4, $t6      # Final grid cell addresszs
    lb $t8, 0($t7)

    # If value at grid location is not zero, pixel2 is occupied
    bnez $t8, end_move

    # If pixel2 not occupied continue
    jr $ra

store_pix1:
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    
    lw $t7, red_col
    beq $t1, $t7, store_red_cap
    lw $t7, blue_col
    beq $t1, $t7, store_blue_cap
    lw $t7, yellow_col
    beq $t1, $t7, store_yellow_cap

store_pix2:
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    
    lw $t7, red_col
    beq $t1, $t7, store_red_cap
    lw $t7, blue_col
    beq $t1, $t7, store_blue_cap
    lw $t7, yellow_col
    beq $t1, $t7, store_yellow_cap 

store_red_cap:
    li $t7, 1
    sb $t7, 0($t6)
    jr $ra
store_blue_cap:
    li $t7, 2
    sb $t7, 0($t6)
    jr $ra
store_yellow_cap:
    li $t7, 3
    sb $t7, 0($t6)
    jr $ra

end_move:    
    li $t3, 8
    sb $t3, pixel1_x
    li $t3, 6
    sb $t3, pixel1_y
    sb $t3, pixel2_y
    li $t3, 9
    sb $t3, pixel2_x
    jal load_capsule
    
    move $ra, $s1
    jr $ra
    
move_down:
    li $a0, 88
    li $a1, 250
    li $a2, 80
    li $a3, 128
    li $v0, 31
    syscall
    move $s1, $ra
    
    # Moving down
    lb $t3, pixel1_y 
    addi $t3, $t3, 1
    sb $t3, pixel1_y
    subi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_y
    addi $t4, $t4, 1
    sb $t4, pixel2_y
    subi $t4, $t4, 1
    move $s4, $t4
    
    lb $t8, pixel2_y
    lb $t9, pixel1_y
    beq $t9, $t8, move_down0
    blt $t9, $t8, move_down2
    blt $t8, $t9, move_down1
   
move_down0:  
    jal check_move0
    
    # Erase current capsule
    lb $a1, pixel1_x
    move $a2, $s3
    lw $t1, black_col
    jal draw_pixel
    
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    move $a2, $s4
    jal draw_pixel
    
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra    

move_down1:
    jal check_move1
    
    # Erase current capsule
    lb $a1, pixel1_x
    move $a2, $s3
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    move $a2, $s4
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra 
    
move_down2:
    jal check_move2
    
    # Erase current capsule
    lb $a1, pixel1_x
    move $a2, $s3
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    move $a2, $s4
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra 
    
    
move_left:
    li $a0, 96
    li $a1, 250
    li $a2, 80
    li $a3, 128
    li $v0, 31
    syscall
    move $s1, $ra
    
    # Moving left
    lb $t3, pixel1_x
    subi $t3, $t3, 1
    sb $t3, pixel1_x
    addi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_x
    subi $t4, $t4, 1
    sb $t4, pixel2_x
    addi $t4, $t4, 1
    move $s4, $t4
    
    lb $t8, pixel2_x
    lb $t9, pixel1_x
    beq $t9, $t8, move_left0
    blt $t9, $t8, move_left1
    blt $t8, $t9, move_left2

move_left0:
    jal check_move0
    
    # Erase current capsule
    move $a1, $s3
    lb $a2, pixel1_y
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    move $a1, $s4
    lb $a2, pixel2_y
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
move_left1:
    jal check_move1
    
    # Erase current capsule
    move $a1, $s3
    lb $a2, pixel1_y
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    move $a1, $s4
    lb $a2, pixel2_y
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
move_left2:
    jal check_move2
    
    # Erase current capsule
    move $a1, $s3
    lb $a2, pixel1_y
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    move $a1, $s4
    lb $a2, pixel2_y
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
move_right:
    li $a0, 97
    li $a1, 250
    li $a2, 80
    li $a3, 128
    li $v0, 31
    syscall
    move $s1, $ra
    
    # Moving right
    lb $t3, pixel1_x
    addi $t3, $t3, 1
    sb $t3, pixel1_x
    subi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_x
    addi $t4, $t4, 1
    sb $t4, pixel2_x
    subi $t4, $t4, 1
    move $s4, $t4
    
    lb $t8, pixel2_x
    lb $t9, pixel1_x
    beq $t9, $t8, move_right0
    blt $t9, $t8, move_right2
    blt $t8, $t9, move_right1
    
move_right0:
    jal check_move0
    # Erase current capsule
    move $a1, $s3
    lb $a2, pixel1_y
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    move $a1, $s4
    lb $a2, pixel2_y
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
move_right1:
    jal check_move1
    # Erase current capsule
    move $a1, $s3
    lb $a2, pixel1_y
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    move $a1, $s4
    lb $a2, pixel2_y
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
move_right2:
    jal check_move2
    # Erase current capsule
    move $a1, $s3
    lb $a2, pixel1_y
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    move $a1, $s4
    lb $a2, pixel2_y
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    # Drawing new one
    lb $a1, pixel1_x
    lb $a2, pixel1_y
    lw $t1, capsule_color1
    jal draw_pixel
    
    jal store_pix1
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra

rotate_capsule:
    li $a0, 99
    li $a1, 250
    li $a2, 80
    li $a3, 128
    li $v0, 31
    syscall
    move $s1, $ra
    
    li $t0, 0
    beq $t0, $s7, pix2_down
    li $t0, 1
    beq $t0, $s7, pix2_pix1
    li $t0, 2
    beq $t0, $s7, pix2_up
    li $t0, 3
    beq $t0, $s7, pix1_pix2

pix2_down:
    li $s7, 1
    # rotation 1
    lb $t3, pixel2_x
    subi $t3, $t3, 1
    sb $t3, pixel2_x
    addi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_y
    addi $t4, $t4, 1
    sb $t4, pixel2_y
    subi $t4, $t4, 1
    move $s4, $t4
    
    # Erase current capsule
    move $a1, $s3
    move $a2, $s4
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
pix2_pix1:
    li $s7, 2
    # rotation 2
    lb $t3, pixel2_x
    subi $t3, $t3, 1
    sb $t3, pixel2_x
    addi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_y
    subi $t4, $t4, 1
    sb $t4, pixel2_y
    addi $t4, $t4, 1
    move $s4, $t4
    
    # Erase current capsule
    move $a1, $s3
    move $a2, $s4
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
pix2_up:
    li $s7, 3
    # rotation 3
    lb $t3, pixel2_x
    addi $t3, $t3, 1
    sb $t3, pixel2_x
    subi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_y
    subi $t4, $t4, 1
    sb $t4, pixel2_y
    addi $t4, $t4, 1
    move $s4, $t4
    
    # Erase current capsule
    move $a1, $s3
    move $a2, $s4
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra
    
pix1_pix2:
    li $s7, 0
    # rotation 0
    lb $t3, pixel2_x
    addi $t3, $t3, 1
    sb $t3, pixel2_x
    subi $t3, $t3, 1
    move $s3, $t3

    lb $t4, pixel2_y
    addi $t4, $t4, 1
    sb $t4, pixel2_y
    subi $t4, $t4, 1
    move $s4, $t4
    
    #jal check_move2
    
    # Erase current capsule
    move $a1, $s3
    move $a2, $s4
    lw $t1, black_col
    jal draw_pixel
    # Calculate the address of the grid cell
    la $t4, grid
    li $t0, 32             # Grid width
    mul $t3, $a2, $t0      # Row offset
    add $t3, $t3, $a1      # Add column index
    add $t6, $t4, $t3      # Final grid cell address
    sb $zero, 0($t6)
    
    lb $a1, pixel2_x
    lb $a2, pixel2_y
    lw $t1, capsule_color2
    jal draw_pixel
    
    jal store_pix2
    
    move $ra, $s1
    jr $ra