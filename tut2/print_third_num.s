# Prints every 3rd number from 24 to 42

# ##############################################################################
# Code Segment

        .text

main:

	# int x = 24
	li	$t0, 24

loop:
	# x < 42
	bge	$t0, 42, end

	# printf("%d\n", x);
	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	# x += 3
	add	$t0, $t0, 3
	b	loop

end:
	# return
	jr	$ra


