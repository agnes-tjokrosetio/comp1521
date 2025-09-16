# This program prints out a danish flag, by
# looping through the rows and columns of the flag.
# Each element inside the flag is a single character.
# (i.e., 1 byte).

# Constants


# ##############################################################################
# Code Segment

        .text

main:
	# initialise row


outer_loop:
	# loop for row < FLAG_ROWS, then exit outer_loop to epilogue


	# initialise col


inner_loop:
	# loop for col < FLAG_COLS, then exit inner_loop to outer_loop_increment


	# calculate &flag[row][col] = base address of flag + (row * FLAG_COLS + col)


	# printf("%c", flag[row][col]);
	# syscall 11: print character


	# increment col and loop back to inner_loop


outer_loop_increment:
	# printf("\n");
	# syscall 11: print character


	# increment row and loop back to outer_loop


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

