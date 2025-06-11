# Prints a right-angled triangle of asterisks, 10 rows high.

# ##############################################################################
# Code Segment

        .text

main:

# initialise i (or whatever the counter is)
	li	$t0, 1 # int i

outer_loop:
# loop for i <= 10, then exit outer_loop

	bgt	$t0, 10, epilogue

# initialise j (or whatever the counter is)
	li	$t1, 0

inner_loop:
	# loop for j < i, then exit inner_loop (i.e. increment outer_loop)

	bge	$t1, $t0, outer_loop_increment

	# printf("%c", '*');
	# syscall 11: print character
	li	$a0, '*'
	li	$v0, 11
	syscall

	# j += 1
	# loop back to inner_loop

	add	$t1, $t1, 1
	b	inner_loop

outer_loop_increment:
	# printf("%c", '\n');
	# syscall 11: print character

	li	$a0, '\n'
	li	$v0, 11
	syscall

	# i += 1
	# loop back to outer_loop
	add	$t0, $t0, 1
	b	outer_loop

epilogue:
	# return from main
        jr      $ra