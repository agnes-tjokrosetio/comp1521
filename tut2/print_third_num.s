# Prints every 3rd number from 24 to 42

# ##############################################################################
# Code Segment

        .text

main:

loop_init:
	# int x = 24;
	li	$t0, 24

loop_cond:
	# x < 42
	bge	$t0, 42, end

loop_body:
	# printf("%d\n", x);
	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

loop_increment:
	# x += 3
	addi	$t0, $t0, 3
	b	loop_cond
end:
	jr	$ra

