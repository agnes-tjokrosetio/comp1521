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
	li	$t0, 0 # row

outer_loop:
	bge	$t0, FLAG_ROWS, end

	li	$t1, 0

inner_loop:
	bge	$t1, FLAG_COLS, outer_loop_increment


	# offset (row x NUM_COLS) + col
	mul	$t2, $t0, FLAG_COLS
	add	$t2, $t2, $t1

# method 1
	# address of flag[row][col]
	# la	$t3, flag
	# add	$t2, $t3, $t2
	# lb	$a0, ($t2)

# method 2:
	lb	$a0, flag($t2)

	li	$v0, 11
	syscall


	add	$t1, $t1, 1
	b	inner_loop

outer_loop_increment:

	li	$a0, '\n'
	li	$v0, 11
	syscall

	add	$t0, $t0, 1
	b	outer_loop

end:
	jr	$ra

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
