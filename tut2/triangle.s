# Prints a right-angled triangle of asterisks, 10 rows high.

# ##############################################################################
# Code Segment

        .text

main:

	# int i = 1
	li	$t0, 1

outer_loop:
	# i <= 10
	bgt	$t0, 10, end

	# int j = 0
	li	$t1, 0
inner_loop:
	# j < i
	bge	$t1, $t0, outer_loop_end

	# printf("*");
	li	$v0, 11
	li	$a0, '*'
	syscall

	# j++
	add	$t1, $t1, 1
	b 	inner_loop

outer_loop_end:
	# printf("\n");
	li	$v0, 11
	li	$a0, '\n'
	syscall

	# i++
	add	$t0, $t0, 1
	b	outer_loop

end:
	# return 0
	li	$v0, 0
	jr	$ra