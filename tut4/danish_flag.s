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

	li	$t0, 0				# int row = 0
outer_loop:
	bge	$t0, FLAG_ROWS, end		# for condition: row < FLAG_ROWS

	li	$t1, 0				# int col = 0
inner_loop:
	bge	$t1, FLAG_COLS, outer_loop_step	# for condition: col < FLAG_COLS

	mul	$t2, $t0, FLAG_COLS		# &flag[row][col]
	add	$t2, $t2, $t1

	la	$t3, flag
	add	$t2, $t2, $t3
	lb	$a0, ($t2)

	# lb	$a0, flag($2)
	li	$v0, 11				# printf("%c", flag[row][col]);
	syscall

	add	$t1, $t1, 1			# col++
	b	inner_loop

outer_loop_step:
	li	$v0, 11				# printf("\n");
	li	$a0, '\n'
	syscall

	add	$t0, $t0, 1			# row++
	b	outer_loop

end:
	jr	$ra				# return

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

