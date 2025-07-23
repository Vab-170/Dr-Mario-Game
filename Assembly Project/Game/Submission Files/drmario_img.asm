dr_mario_virus:
    lw $t2, ADDR_DSPL      # Load display base address
    
    move $s1, $ra

    li $a1, 22
    li $a2, 16
    li $a3, 28
    li $a0, 23
    lw $t1, skin_col
    jal draw_block         # head
    
    li $a1, 22
    li $a2, 16
    lw $t1, yellow_col
    jal draw_pixel  # light
    
    li $a1, 22
    li $a2, 17
    lw $t1, black_col
    jal draw_pixel  # light
    
    li $a1, 21
    li $a2, 17
    li $a3, 19
    lw $t1, black_col
    jal vert_border_loop
    
    li $a1, 25
    li $a2, 16
    li $a3, 30
    li $a0, 22
    la $t1, 0x654321
    jal draw_block  # back head hair
    
    li $a1, 24
    li $a2, 17
    la $t1, black_col
    jal draw_pixel  # head strap start
    
    li $a1, 25
    li $a2, 17
    li $a3, 29
    la $t1, 0x0000ff
    jal hrznt_border_loop   # rest of head strap
    
    li $a1, 28
    li $a2, 19
    li $a3, 21
    lw $t1, skin_col
    jal vert_border_loop   # ear
    
    li $a1, 25
    li $a2, 21
    li $a3, 28
    lw $t1, skin_col
    jal hrznt_border_loop   # side_burns
    
    li $a1, 26
    li $a2, 19
    lw $t1, skin_col
    jal draw_pixel  # side_burn cut
    
    li $a1, 25
    li $a2, 18
    li $a3, 21
    jal vert_border_loop   # left column
    
    li $a1, 28
    li $a2, 16
    li $a3, 30
    lw $t1, black_col
    jal hrznt_border_loop
    
    li $a1, 29
    li $a2, 16
    li $a3, 19
    jal vert_border_loop   # left column
    
    li $a1, 23
    li $a2, 18
    lw $t1, eye_blue
    jal draw_pixel  # eye top
    
    li $a1, 23
    li $a2, 19
    la $t1, 0x0000ff
    jal draw_pixel  # eye bottom
    
    li $a1, 20
    li $a2, 19
    li $a3, 22
    la $t1, 0xffc3d3
    jal hrznt_border_loop   # nose
    
    li $a1, 19
    li $a2, 20
    li $a3, 22
    lw $t1, skin_col
    jal hrznt_border_loop   # nose
    
    li $a1, 20
    li $a2, 21
    li $a3, 24
    la $t1, 0x224400
    jal hrznt_border_loop   # mustache
    
    li $a1, 22
    li $a2, 20
    la $t1, 0x224400
    jal draw_pixel
    
    li $a1, 23
    li $a2, 23
    li $a3, 29
    lw $t1, white_col
    jal hrznt_border_loop   # neck
    
    li $a1, 23
    li $a2, 23
    li $a3, 25
    lw $t1, red_col
    jal hrznt_border_loop   # collar 
    
    li $a1, 20
    li $a2, 24
    li $a3, 30
    lw $t1, white_col
    jal hrznt_border_loop   # shoulders
    
    li $a1, 24
    li $a2, 24
    lw $t1, red_col
    jal draw_pixel
    
    li $a1, 19
    li $a2, 25
    li $a3, 31
    li $a0, 29
    lw $t1, white_col
    jal draw_block         # body
    
    li $a1, 21
    li $a2, 29
    li $a3, 24
    lw $t1, blue_col
    jal hrznt_border_loop   # left pant
    
    li $a1, 26
    li $a2, 29
    li $a3, 29
    lw $t1, blue_col
    jal hrznt_border_loop   # right pant       
    
    li $a1, 19
    li $a2, 30
    li $a3, 23
    li $a0, 32
    lw $t1, brown_col
    jal draw_block
    
    li $a1, 19
    li $a2, 30
    lw $t1, black_col
    jal draw_pixel 
    
    # Drawing his right shoe
    li $a1, 27
    li $a2, 30
    li $a3, 31
    li $a0, 32
    lw $t1, brown_col
    jal draw_block
    
    li $a1, 30
    li $a2, 30
    lw $t1, black_col
    jal draw_pixel 
    
    # Drawing first yellow virus
    li $a1, 27
    li $a2, 10
    li $a3, 32
    li $a0, 14
    lw $t1, yellow_col
    jal draw_block
    
    li $a1, 28
    li $a2, 11
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 30
    li $a2, 11
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 31
    li $a2, 13
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 27
    li $a2, 13
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 29
    li $a2, 13
    lw $t1, black_col
    jal draw_pixel
    
    jal delay 
    
    # Drawing second blue virus
    li $a1, 20
    li $a2, 8
    li $a3, 25
    li $a0, 12
    lw $t1, blue_col
    jal draw_block
    
    li $a1, 21
    li $a2, 9
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 23
    li $a2, 9
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 20
    li $a2, 11
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 24
    li $a2, 11
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 22
    li $a2, 11
    lw $t1, black_col
    jal draw_pixel
    
    jal delay 
    
    # Drawing third red virus
    li $a1, 15
    li $a2, 2
    li $a3, 20
    li $a0, 6
    lw $t1, red_col
    jal draw_block
    
    li $a1, 16
    li $a2, 3
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 18
    li $a2, 3
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 15
    li $a2, 5
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 17
    li $a2, 5
    lw $t1, black_col
    jal draw_pixel
    
    li $a1, 19
    li $a2, 5
    lw $t1, black_col
    jal draw_pixel
    move $ra, $s1
    jr $ra
    

# Arguments:
#   $a1: start column (x)
#   $a2: start row (y)
#   $a3: end column (x + width)
#   $a4: end row (y + height)
draw_block:
    move $t5, $a2          # Copy start row to $t5
row_loop:
    move $t6, $a1          # Copy start column to $t6
col_loop:
    mul $t7, $t5, 32       # Row offset
    add $t8, $t7, $t6      # Total offset = column + row_offset
    sll $t8, $t8, 2        # Convert the offset to bytes
    add $t9, $t2, $t8      # Final Address = base address + byte offset
    sw $t1, 0($t9)         # Store the red pixel color at the address

    addi $t6, $t6, 1        # Move to the next column
    blt $t6, $a3, col_loop # If column is within bounds, continue loop

    addi $t5, $t5, 1       # Move to the next row
    blt $t5, $a0, row_loop
    
    jr $ra                  # Return from function
