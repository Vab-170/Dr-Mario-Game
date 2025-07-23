# Set gravity based on key press
set_gravity:
    jal key_check
    beq $a0, 0x65, set_easy
    beq $a0, 0x6D, set_med
    beq $a0, 0x68, set_hard
    j set_gravity

set_easy:
    la $t0, GRAVITY_DELAYE
    lw $s0, 0($t0)
    j set_gravity_done

set_med:
    la $t0, GRAVITY_DELAYM
    lw $s0, 0($t0)
    j set_gravity_done

set_hard:
    la $t0, GRAVITY_DELAYH
    lw $s0, 0($t0)
    j set_gravity_done

set_gravity_done:
    sw $s0, mod_delay
    jal move_down
    
SkipGravity:
    lw $s0, mod_delay
    subi $s0, $s0, 1
    sw $s0, mod_delay
    bgtz $s0, SkipGravity
    jal game_loop