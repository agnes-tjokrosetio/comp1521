# Computes factorials using no functions (except main)

# ##############################################################################
# Code Segment

        .text

main:
	# printf("n  = ");
	li	$v0, 4
	la	$a0, input_str
	syscall

	# scanf("%d", &n);
	li	$v0, 5
	syscall
	move	$t0, $v0

	# int fac = 1
	li	$t1, 1

	# int i = 1
	li	$t2, 1

loop:
	# i <= n
	bgt	$t2, $t0, end

	# fac *= i
	mul	$t1, $t1, $t2

	# i++
	add	$t2, $t2, 1
	b	loop

end:

	# printf("n! = %d\n", fac);
	li	$v0, 4
	la	$a0, output_str
	syscall

	move	$a0, $t1
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, newline
	syscall

	# return 0
	li	$v0, 0
	jr	$ra


# ##############################################################################
# Data Segment

        .data
input_str:
	.asciiz "n  = "

output_str:
	.asciiz "n! = "

newline:
	.asciiz "\n"
