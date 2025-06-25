# This program prints out a danish flag, by
# looping through the rows and columns of the flag.
# Each element inside the flag is a single character.
# (i.e., 1 byte).

# Constants
FLAG_ROWS = 6
FLAG_COLS = 12

# ##############################################################################
# Code Segment

        .text

main:

	# initialise row
	li	$t0, 0

outer_loop:
	# loop for row < FLAG_ROWS, then exit outer_loop to epilogue
	bge	$t0, FLAG_ROWS, epilogue

	# initialise col
	li	$t1, 0

inner_loop:
	# loop for col < FLAG_COLS, then exit inner_loop to outer_loop_increment
	bge	$t1, FLAG_COLS, outer_loop_increment

	# calculate &flag[row][col] = base address of flag + (row * FLAG_COLS + col)
	mul	$t2, $t0, FLAG_COLS
	add	$t2, $t2, $t1

	# la	$t3, flag
	# add	$t2, $t3, $t2

	lb	$a0, flag($t2)

	# printf("%c", flag[row][col]);
	# syscall 11: print character
	li	$v0, 11
	syscall

	# increment col and loop back to inner_loop
	add	$t1, $t1, 1
	b	inner_loop

outer_loop_increment:
	# printf("\n");
	# syscall 11: print character
	li	$a0, '\n'
	li	$v0, 11
	syscall

	# increment row and loop back to outer_loop
	add	$t0, $t0, 1
	b	outer_loop

epilogue:
	# return from main
        jr      $ra

# ##############################################################################
# Data Segment

	.data

flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'

