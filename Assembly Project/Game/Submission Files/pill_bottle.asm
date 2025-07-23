draw:
    lw $t2, ADDR_DSPL
    lw $t1, grey_col
    
    # Save return address
    move $s1, $ra
    
    # Redraw the borders and pixels one by one
    li $a1, 5   # start col 5
    li $a2, 4   # row 4
    li $a3, 7   # end col 7
    jal hrznt_border_loop   # top left notch
    
    jal delay  # Wait for animation delay

    li $a1, 6   # col 6
    li $a2, 4   # start row 4
    li $a3, 8   # end row 8
    jal vert_border_loop   # top left column
    
    jal delay  # Wait for animation delay

    li $a1, 0   # start col 0
    li $a2, 8   # row 8
    li $a3, 7   # end col 7
    jal hrznt_border_loop   # bottom left row
    
    jal delay  # Wait for animation delay

    li $a1, 0  # col 0
    li $a2, 8  # start row 8
    li $a3, 32 # end row 32
    jal vert_border_loop   # left column
    
    jal delay  # Wait for animation delay

    li $a1, 0   # start col 0
    li $a2, 31  # row 31
    li $a3, 17  # end col 17
    jal hrznt_border_loop   # bottom row
    
    jal delay  # Wait for animation delay

    li $a1, 17  # col 17
    li $a2, 8   # start row 8
    li $a3, 32  # end row 32
    jal vert_border_loop   # right column
    
    jal delay  # Wait for animation delay

    li $a1, 11  # start col 11
    li $a2, 8   # row 8
    li $a3, 17  # end col 17
    jal hrznt_border_loop   # top right row
    
    jal delay  # Wait for animation delay

    li $a1, 11  # col 11
    li $a2, 4   # start row 4
    li $a3, 8   # end row 8
    jal vert_border_loop    # top right column
    
    jal delay
    
    li $a1, 12  # start col 12
    li $a2, 4   # row 4
    li $a3, 13  # end col 13
    jal hrznt_border_loop   # top right notch
    
    jal delay  # Wait for animation delay
    
    li $a1, 24  # start col 24
    li $a2, 1   # row 1
    li $a3, 31  # end col 31
    jal hrznt_border_loop   # top score border
    
    jal delay  # Wait for animation delay
    
    li $a1, 31  # col 31
    li $a2, 1   # start row 1
    li $a3, 6   # end row 6
    jal vert_border_loop    # right score border
    
    jal delay
    
    li $a1, 24  # start col 24
    li $a2, 6   # row 6
    li $a3, 32  # end col 32
    jal hrznt_border_loop   # bottom score border
    
    jal delay  # Wait for animation delay
    
    li $a1, 24  # col 24
    li $a2, 1   # start row 1
    li $a3, 6   # end row 6
    jal vert_border_loop    # left score border
    
    jal delay
    
    move $ra, $s1   # Restore return address before returning
    jr $ra

vert_border_loop:
    # $a0: Base address of the display
    # $a1: Column
    # $a2: Starting row
    # $a3: Ending row
    # $t1: Color
    
    loop_vert:
        mul $t4, $a2, 32
        add $t5, $t4, $a1
        sll $t5, $t5, 2

        add $t6, $t2, $t5
        sw $t1, 0($t6)
        
        # Calculate the address of the grid cell
        la $t4, grid
        li $t0, 32             # Grid width
        mul $t3, $a2, $t0      # Row offset
        add $t3, $t3, $a1  # Add column index
        add $t6, $t4, $t3      # Final grid cell address
        
        lw $t5, grey
        sb $t5, 0($t6)         # Store the pixel depiction in $t6
    
        # Increment the row counter
        addi $a2, $a2, 1

        # Check if we have reached the end row
        blt $a2, $a3, loop_vert
    jr $ra
    
hrznt_border_loop:
    # $a0: Base address of the display
    # $a1: Starting column
    # $a2: Row
    # $a3: Ending column
    # $t1: Color
    
    # Loop through each column from start column to end column
    loop_hrznt:
        mul $t4, $a2, 32
        add $t5, $t4, $a1
        sll $t5, $t5, 2

        add $t6, $t2, $t5
        sw $t1, 0($t6)
        
        # Calculate the address of the grid cell
        la $t4, grid
        li $t0, 32             # Grid width
        mul $t3, $a2, $t0      # Row offset
        add $t3, $t3, $a1  # Add column index
        add $t6, $t4, $t3      # Final grid cell address
        
        lw $t5, grey
        sb $t5, 0($t6)         # Store the pixel depiction in $t6
        
        # Increment the column counter
        addi $a1, $a1, 1

        # Check if we have reached the end column
        blt $a1, $a3, loop_hrznt
    jr $ra

# For animation
delay:
    li $t0, 1900000            # Set delay counter
delay_loop:
    subi $t0, $t0, 1
    bnez $t0, delay_loop  # Loop until counter reaches 0
    jr $ra