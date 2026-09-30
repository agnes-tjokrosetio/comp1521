# ##############################################################################
# Code Segment

	.text

main:
	la	$t0, string	# char *s = &string[0];
	li	$t1, 0		# int length = 0;

while:
	lb	$t2, ($t0)	# *s
	beq	$t2, '\0', end	# while *s != '\0

	add	$t1, $t1, 1	# length++
	add	$t0, $t0, 1	# s++

	b	while

end:
	move	$a0, $t1	# printf("%d", length)
	li	$v0, 1
	syscall

	jr	$ra

# ##############################################################################
# Data Segment

	.data
string:
	.asciiz "...."