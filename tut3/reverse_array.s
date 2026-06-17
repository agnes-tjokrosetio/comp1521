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
	# i = 0
	li	$t0, 0

loop:
	# while (i < N_SIZE_D_2)
	bge	$t0, N_SIZE_D_2, print

	# numbers[i]
	mul	$t1, $t0, 4
	lw	$t3, numbers($t1) # x

	# numbers[N_SIZE_M_1 - i]
	sub	$t4, N_SIZE_M_1, $t0
	mul	$t4, $t4, 4
	lw	$t5, numbers($t4) # y

	# numbers[i] = y;
	sw	$t5, numbers($t1)
	# numbers[N_SIZE_M_1 - i] = x;
	sw	$t3, numbers($t4)

	# i++;
	add	$t0, $t0, 1
	b	loop


# PRINT LOOP

print:	
	# i = 0
	li	$t0, 0

loop_print:
	# while (i < N_SIZE)
	bge	$t0, N_SIZE, end 

	# &numbers[i]
	la	$t1, numbers
	mul	$t2, $t0, 4
	add	$t3, $t2, $t1

	# printf("%d", numbers[i])
	lw	$a0, ($t3)
	li	$v0, 1
	syscall

	# putchar(' ')
	li	$a0, ' '
	li	$v0, 11
	syscall

	# i++
	add	$t0, $t0, 1
	b	loop_print

end:
	jr	$ra


# ##############################################################################
# Data Segment

        .data
# int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
numbers:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
