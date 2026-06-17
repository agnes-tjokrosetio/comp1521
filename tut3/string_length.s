# ##############################################################################
# Code Segment

	.text

main:
	# char *string = "....";
	la	$t0, string
	# int   length = 0;
	li	$t1, 0

loop_cond:
	# char *s = &string[i];
	lb	$t2, ($t0)

	# while (*s != '\0') {
	beq	$t2, '\0', loop_end

loop_body:
	# length++;
	add	$t1, $t1, 1
	# s++;
	add	$t0, $t0, 1

	b	loop_cond

loop_end:
	# print length
	move	$a0, $t1
	li	$v0, 1
	syscall

	# return
	jr	$ra


# ##############################################################################
# Data Segment

	.data
string:
	.asciiz "...."