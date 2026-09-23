# Prints the square of a number

# ##############################################################################
# Code Segment

        .text

main:
	# printf("Enter a number: ");
	li	$v0, 4
	la	$a0, prompt
	syscall

	# scanf("%d", &x);
	li	$v0, 5
	syscall
	move	$t0, $v0

	# y = x * x;
	mul	$t1, $t0, $t0

	# printf("%d\n", y);
	move	$a0, $t1
	li	$v0, 1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	# return 0;
	li	$v0, 0
	jr	$ra

# ##############################################################################
# Data Segment

        .data
prompt:
	.asciiz "Enter a number: "