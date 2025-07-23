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
    
# Colors needed in the games have been hard-coded
grey_col:
    .word 0x808080
red_col:
    .word 0xff0000
green_col:
    .word 0x00ff00
blue_col:
    .word 0x0000ff
yellow_col:
    .word 0xffff00
black_col:
    .word 0x000000
brown_col:
    .word 0x964b00
white_col:
    .word 0xfefdff
eye_blue:
    .word 0x7cb9e8
skin_col:
    .word 0xefdecd
GRAVITY_DELAY:
    .word 1000000
GRAVITY_DELAYE:
    .word 1990000
GRAVITY_DELAYH:
    .word 100000
GRAVITY_DELAYM:
    .word 1000000
gravity_set_flag:
    .word 0
# easy level: 1990000
# medium level: 1000000
# hard level: 100000
mod_delay:
    .word 10
grey: .word 00001
##############################################################################
# Mutable Data
##############################################################################
# colomn: 0 - 18 (usable you will reach the border after these values) 18 
# rows:   6 - 30 (usable you will reach the border after these values) 24

grid:
    .space 1024 # An array that holds 1024 pixels
pixel1_x: 
    .byte 8
pixel1_y:
    .byte 6
pixel2_x:
    .byte 9
pixel2_y: 
    .byte 6
capsule_color1: 
    .word 0x000000
capsule_color2: 
    .word 0x000000
score:
    .word 0x670000
    
##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:
    # Initialize the game
    # Drawing the pill bottle
    jal draw
    
    jal load_color
    jal place_virus
    
    jal delay
    
    jal load_color
    jal place_virus
    
    jal delay
    
    jal load_color
    jal place_virus
    
    jal delay
    
    jal load_color
    jal place_virus
    
    jal delay
    
    # Drawing the Dr Mario and virus pictures
    jal dr_mario_virus
    
    jal delay 
    
    # Drawing the initial capsule
    jal load_capsule
    
    #jal set_gravity

game_loop:
    # Asking user for input
    jal key_check
    
    #jal set_gravity
    #jal check_match
    
    jal gravity_timer    
    
    j game_loop

.include "pill_bottle.asm"
.include "movement.asm"
.include "capsule_create.asm"
.include "random.asm"
.include "load_virus_col.asm"
.include "place_pixel.asm"
.include "drmario_img.asm"
#.include "gravity.asm"
.include "gravity_simple.asm"
.include "check_match.asm"
.include "score.asm"
