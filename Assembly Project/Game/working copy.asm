################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Vaibhav Gupta
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
dskin_col:
    .word 0xccffb3
    
# Frame Delay value for the game to run at 60 fps
FRAME_DELAY:
    .byte 16666667
    
Active_Capsule:
    .word 00000 000 00000 000 00000 000
# xxxxx nnn yyyyy nnn 00000 nds
# the first 5 bits (reading from left-right) denote the x value and the next 3 dont matter
# the next 5 bits are the y value and then the next 3 dont matter
# the next 5 bits are the capsule type 
# the next bit does not matter
# the bit after that is if that bit is to be deleted (just moved or 4 of the same matched)
# the next bit is the state for implementing state for gravity
    
RRR: .word 00000
RBR: .word 00001
RLR: .word 00010
RTR: .word 00011

RRB: .word 00100
RBB: .word 00101
RLB: .word 00110
RTB: .word 00111

RRY: .word 01000
RBY: .word 01001
RLY: .word 01010
RTY: .word 01011

BRB: .word 01100
BBB: .word 01110
BLB: .word 01111
BTB: .word 10000

BRY: .word 10001
BBY: .word 10010
BLY: .word 10011
BTY: .word 10100
 
YRY: .word 10101
YBY: .word 10110
YLY: .word 10111
YTY: .word 11000

BLR: .word 11001
YLR: .word 11010
YLB: .word 11011
# Types of pills
# 00000: main pill is RED and right pill is RED
# 00001: main pill is RED and bottom pill is RED
# 00010: main pill is RED and left pill is RED
# 00011: main pill is RED and top pill is RED

# 00100: main pill is RED and right pill is BLUE
# 00101: main pill is RED and bottom pill is BLUE
# 00110: main pill is RED and left pill is BLUE
# 00111: main pill is RED and top pill is BLUE

# 01000: main pill is RED and right pill is YELLOW
# 01001: main pill is RED and bottom pill is YELLOW
# 01010: main pill is RED and left pill is YELLOW
# 01011; main pill is RED and top pill is YELLOW

# 01100: main pill is BLUE and right pill is BLUE
# 01110: main pill is BLUE and bottom pill is BLUE
# 01111: main pill is BLUE and left pill is BLUE
# 10000; main pill is BLUE and top pill is BLUE

# 10001; main pill is BLUE and right pill is YELLOW
# 10010; main pill is BLUE and bottom pill is YELLOW
# 10011; main pill is BLUE and left pill is YELLOW
# 10100; main pill is BLUE and top pill is YELLOW

# 10101; main pill is YELLOW and right pill is YELLOW
# 10110; main pill is YELLOW and bottom pill is YELLOW
# 10111; main pill is YELLOW and left pill is YELLOW
# 11000; main pill is YELLOW and top pill is YELLOW
##############################################################################
# Mutable Data
##############################################################################
# colomn: 3 - 18 (usable you will reach the border after these values) 15 
# rows:   9 - 30 (usable you will reach the border after these values) 21
# pixel distribution:
# 7 - 1 if the capsule is falling and 0 if its static
# 6 - bit that determines the orientation mostly for capsule structures
# 5 - bit that determines if the pixel is top when vertical 
# 4 - 1-virus, 0-capsule
# 3-2 - these bits determine the color, 00-red, 01-blue, 10-yellow, 11-grey
# 1 - unused bit for now
# 0 - 1-if pill bottle, 0 if anything else
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
    
    jal dr_mario_virus
    
    jal delay 
    
    # Drawing the initial capsule
    jal load_capsule

game_loop:
    # Asking user for input
    jal key_check

    # 6. Repeat the game loop
    j game_loop
    # 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (capsules)
	# 3. Draw the screen
	# 4. Sleep
    # 5. Go back to Step 1

.include "pill_bottle.asm"
.include "movement.asm"
.include "capsule_create.asm"
.include "random.asm"
.include "load_virus_col.asm"
.include "place_pixel.asm"
.include "drmario_img.asm"
