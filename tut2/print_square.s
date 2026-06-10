# Prints the square of a number

# ##############################################################################
# Code Segment

        .text

main:
	
	li	$v0, 4			# printf("Enter a number: ");
	la	$a0, prompt_str
	syscall

	li	$v0, 5			# scanf("%d", &x);
	syscall

	mul	$t0, $v0, $v0 		# y = x * x

	li	$v0, 1			# printf("%d\n", y);
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 0			# return 0
	jr	$ra

# ##############################################################################
# Data Segment

        .data
prompt_str:
	.asciiz "Enter a number: "