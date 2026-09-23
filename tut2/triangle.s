# Prints a right-angled triangle of asterisks, 10 rows high.

# ##############################################################################
# Code Segment

        .text

main:
	# int i
	li	$t0, 1

out_loop:
	# i <= 10
	bgt	$t0, 10, end

	# int j
	li	$t1, 0
inner_loop:
	# j < i
	bge	$t1, $t0, out_loop_increment

	# printf("*");
	li	$v0, 11
	li	$a0, '*'
	syscall

	# j++
	addi	$t1, $t1, 1
	b	inner_loop

out_loop_increment:
	# printf("\n");
	li	$v0, 11
	li	$a0, '\n'
	syscall

	# i++
	addi	$t0, $t0, 1
	b	out_loop

end:
	# return 0
        jr      $ra