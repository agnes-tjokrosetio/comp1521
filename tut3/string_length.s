# ##############################################################################
# Code Segment

	.text

main:
	la	$t0, string

	li	$t1, 0

loop:
	lb	$t2, ($t0)
	beq	$t2, '\0', end

	add	$t0, $t0, 1
	add	$t1, $t1, 1

	b	loop

end:

	move	$a0, $t1
	li	$v0, 1
	syscall

	jr	$ra

# ##############################################################################
# Data Segment

	.data
string:
	.asciiz "...."