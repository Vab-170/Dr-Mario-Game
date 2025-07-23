load_color:
# Registers Used in function
# $s1 - Saves the return address
# $a1 - holds the upper bound for the random_in_range fxn
# $t3 - holds the random color fxn
# $a0 - holds the return value from the random_in_range fxn
    # Save return address
    move $s1, $ra

    # Generate a random number (0, 1, or 2) for color selection
    li $a1, 3             # Upper bound for random_in_rnage fxn (0 <= $v0 < 3)
    jal random_in_range
    move $t3, $a0         # Store random number in $t3
    
    # Restore return address (now that random_in_range is done)
    move $ra, $s1
    
    # Select the color based on the random number
    beq $t3, 0, load_red      # If 0, load red
    beq $t3, 1, load_blue     # If 1, load blue
    beq $t3, 2, load_yellow   # If 2, load yellow
    
load_red:
    lw $t1, red_col        # Load red color into $t1
    jr $ra

load_blue:
    lw $t1, blue_col       # Load blue color into $t1
    jr $ra

load_yellow:
    lw $t1, yellow_col     # Load yellow color into $t1
    jr $ra