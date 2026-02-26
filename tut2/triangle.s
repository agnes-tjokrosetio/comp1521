# Prints a right-angled triangle of asterisks, 10 rows high.

# ##############################################################################
# Code Segment

        .text

main:
	li	$t0, 1 # i

outer_loop:
	# outer loop condition
	bgt	$t0, 10, end

	# outer loop body
	li	$t1, 0 # j

inner_loop:
	# inner loop condition
	bge	$t1, $t0, outer_loop_increment

	# inner loop body
	li	$a0, '*'
	li	$v0, 11
	syscall

	# inner loop increment
	add	$t1, $t1, 1
	b	inner_loop

outer_loop_increment:
        # printf("%c", '\n');
	li	$a0, '\n'
	li	$v0, 11
	syscall

	add	$t0, $t0, 1
	b	outer_loop

end:
        jr      $ra