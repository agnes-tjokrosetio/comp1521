# A short program that reverses an array by swapping elements.
# Note that since we end up using more registers, we need more documentation. 

# Constants
N_SIZE = 10
N_SIZE_M_1 = N_SIZE - 1
N_SIZE_D_2 = N_SIZE / 2

# ##############################################################################
# Code Segment

        .text

main:
	li	$t0, 0

loop:
	bge	$t0, N_SIZE_D_2, end_loop

	# numbers[i]
	mul	$t1, $t0, 4
	lw	$t2, numbers($t1)

	# numbers[N_SIZE_M_1 - i]
	sub	$t3, N_SIZE_M_1, $t0
	mul	$t3, $t3, 4
	lw	$t4, numbers($t3)

	sw	$t2, numbers($t3)
	sw	$t4, numbers($t1)

	add	$t0, $t0, 1
	b	loop

end_loop:
	li	$t0, 0
	
print_loop:
	bge	$t0, 40, end

	lw	$a0, numbers($t0)
	li	$v0, 1
	syscall

	li	$a0, ' '
	li	$v0, 11
	syscall

	add	$t0, $t0, 4
	b	print_loop

end:
	jr	$ra


# ##############################################################################
# Data Segment

        .data
# int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
numbers:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9