# Gravity Timer
gravity_timer:
    lw $s0, GRAVITY_DELAY # Reset timer
    sw $s0, mod_delay
    jal  move_down          # Trigger gravity by calling move_down
SkipGravity:
    lw $s0, mod_delay
    subi $s0, $s0, 1
    sw $s0, mod_delay
    bgtz $s0, SkipGravity
    jal game_loop