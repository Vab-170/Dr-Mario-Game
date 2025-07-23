################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Vaibhav Gupta, 1010324711
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       2
# - Unit height in pixels:      2
# - Display width in pixels:    64
# - Display height in pixels:   64
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000
grey_col: .word 0x404040
red_col: .word 0xff0000
green_col: .word 0x00ff00
blue_col: .word 0x0000ff
yellow_col: .word 0xffff00
colors: .word 0xff0000, 0xffff00, 0x0000ff
num_colors:         .word 3

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
lw $t1, grey_col

lw $t0, ADDR_DSPL   # $t0 = base address of display (0x10008000)
    
li $t2, 6 # col 6
li $t3, 8 # row 8
left_border_loop:
    mul $t4, $t3, 32            # Row offset = row * 32
    add $t5, $t4, $t2           # Column offset = column + row_offset
    sll $t5, $t5, 2             # Convert the offset to bytes

    add $t6, $t0, $t5
    sw $t1, 0($t6)              # Set the pixel color to red

    # Increment the row counter
    addi $t3, $t3, 1            # Move to the next row

    # Continue the loop until all 16 rows are printed
    li $t7, 32                       # $t7 = 32 rows
    blt $t3, $t7, left_border_loop   # Repeat the loop until row 32
    
li $t2, 26   # col 26
li $t3, 8    # row 8
right_border_loop:
    mul $t4, $t3, 32            # Row offset = row * 32
    add $t5, $t4, $t2           # Column offset = column + row_offset
    sll $t5, $t5, 2             # Convert the offset to bytes

    add $t6, $t0, $t5
    sw $t1, 0($t6)              # Set the pixel color to red

    # Increment the row counter
    addi $t3, $t3, 1            # Move to the next row

    # Continue the loop until all 16 rows are printed
    li $t7, 32                        # $t7 = 32 rows
    blt $t3, $t7, right_border_loop   # Repeat the loop until row 32

li $t2, 31     # row 31
li $t3, 6      # col 6
bottom_border_loop:
    mul $t4, $t2, 32           # Row offset = row * 32
    add $t5, $t4, $t3          # Total offset = row_offset + column
    sll $t5, $t5, 2            # Convert the offset to bytes
    
    add $t6, $t0, $t5
    sw $t1, 0($t6)             # Set the pixel color to red

    addi $t3, $t3, 1           # Move to the next column

    li $t7, 26                 # $t7 = 26
    blt $t3, $t7, bottom_border_loop  # Repeat the loop for all columns

li $t2, 14     # col 14
li $t3, 4      # row 
top1_border_loop:
    mul $t4, $t3, 32            # Row offset = row * 32
    add $t5, $t4, $t2           # Column offset = column + row_offset
    sll $t5, $t5, 2             # Convert the offset to bytes

    add $t6, $t0, $t5
    sw $t1, 0($t6)              # Set the pixel color to red

    addi $t3, $t3, 1            # Move to the next row

    li $t7, 8                 # $t7 = 8
    blt $t3, $t7, top1_border_loop  # Repeat the loop until row 8


li $t2, 18     # col 18
li $t3, 4      # row 4
top2_border_loop:
    mul $t4, $t3, 32           # Row offset = row * 32
    add $t5, $t4, $t2           # Column offset = column + row_offset
    sll $t5, $t5, 2             # Convert the offset to bytes

    add $t6, $t0, $t5           # $t6 = address of the pixel at (row, column)
    sw $t1, 0($t6)              # Set the pixel to red

    addi $t3, $t3, 1            # Move to the next row

    li $t7, 8                 # $t7 = 8
    blt $t3, $t7, top2_border_loop  # Repeat the loop until row 8
    

li $t2, 8      # row 8
li $t3, 6      # col 6
toplef_border_loop:
    mul $t4, $t2, 32           # Row offset = row * 32
    add $t5, $t4, $t3          # Total offset = row_offset + column
    sll $t5, $t5, 2            # Convert the offset to bytes

    add $t6, $t0, $t5
    sw $t1, 0($t6)             # Set the pixel to red

    addi $t3, $t3, 1           # Move to the next column

    li $t7, 15                 # $t7 = 15
    blt $t3, $t7, toplef_border_loop  # Repeat the loop for all columns
    

li $t2, 8        # row 8
li $t3, 18       # col 18
topr_border_loop:
    mul $t4, $t2, 32           # Row offset = row * 32
    add $t5, $t4, $t3          # Total offset = row_offset + column
    sll $t5, $t5, 2            # Convert the offset to bytes

    add $t6, $t0, $t5          # $t6 = address of the pixel at (row, column)
    sw $t1, 0($t6)             # Set the pixel to red

    addi $t3, $t3, 1           # Move to the next column

    li $t7, 26                 # $t7 = 26
    blt $t3, $t7, topr_border_loop  # Repeat the loop for all columns
virus1: 
    li $t2, 12        # row 8
    li $t3, 16       # col 18
    lw $t1, red_col
    mul $t4, $t2, 32           # Row offset = row * 32
    add $t5, $t4, $t3          # Total offset = row_offset + column
    sll $t5, $t5, 2            # Convert the offset to bytes
    add $t6, $t0, $t5
    sw $t1, 0($t6)
    
virus2: 
    li $t2, 20        # row 8
    li $t3, 10       # col 18
    lw $t1, green_col
    mul $t4, $t2, 32           # Row offset = row * 32
    add $t5, $t4, $t3          # Total offset = row_offset + column
    sll $t5, $t5, 2            # Convert the offset to bytes
    add $t6, $t0, $t5
    sw $t1, 0($t6)
    
virus3: 
    li $t2, 26        # row 8
    li $t3, 20       # col 18
    lw $t1, blue_col
    mul $t4, $t2, 32           # Row offset = row * 32
    add $t5, $t4, $t3          # Total offset = row_offset + column
    sll $t5, $t5, 2            # Convert the offset to bytes
    add $t6, $t0, $t5
    sw $t1, 0($t6)
    
capsule:
    li $t2, 3
    li $t3, 24
    lw $t1, blue_col
    mul $t4, $t2, 32
    add $t5, $t4, $t3
    sll $t5, $t5, 2
    add $t6, $t0, $t5
    sw $t1, 0($t6)
    
    li $t2, 4
    li $t3, 24
    lw $t1, red_col
    mul $t4, $t2, 32
    add $t5, $t4, $t3
    sll $t5, $t5, 2
    add $t6, $t0, $t5
    sw $t1, 0($t6)
    
capsule1:
    li $t2, 5
    li $t3, 16
    lw $t1, yellow_col
    mul $t4, $t2, 32
    add $t5, $t4, $t3
    sll $t5, $t5, 2
    add $t6, $t0, $t5
    sw $t1, 0($t6)
    
    li $t2, 6
    li $t3, 16
    lw $t1, yellow_col
    mul $t4, $t2, 32
    add $t5, $t4, $t3
    sll $t5, $t5, 2
    add $t6, $t0, $t5
    sw $t1, 0($t6)

# Exit program
li $v0, 10                   # Exit syscall
syscall