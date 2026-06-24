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
	li	$t0, 0 					# row = 0

outer_loop:
	bge	$t0, FLAG_ROWS, end			# row < FLAG_ROWS

	li	$t1, 0					# col = 0
inner_loop:
	bge	$t1, FLAG_COLS, outer_loop_increment	# col < FLAG_COLS

	la	$t2, flag				# base address of flag
	mul	$t3, $t0, FLAG_COLS			# (row * total cols + cols) * sizeof(element)
	add	$t3, $t3, $t1
	add	$t3, $t3, $t2				# address of flag[row][col]

	lb	$a0, ($t3)				# printf("%c", flag[row][col]);
	li	$v0, 11
	syscall

	add	$t1, $t1, 1				# col++
	j	inner_loop

outer_loop_increment:

	li	$v0, 11					# printf("\n");
	li	$a0, '\n'
	syscall

	add	$t0, $t0, 1				# row++
	j	outer_loop

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

