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
loop_init:
	li	$t0, 0				# int i = 0
loop_cond:
	bge	$t0, N_SIZE_D_2, print		# while (i < N_SIZE_D_2)

loop_body:
	la	$t1, numbers			# &numbers[i];
	mul	$t2, $t0, 4
	add	$t3, $t2, $t1
	lw	$t4, ($t3)			# int x = numbers[i];

	sub	$t5, N_SIZE_M_1, $t0 		# N_SIZE_M_1 - i
	mul	$t6, $t5, 4			# & numbers[N_SIZE_M_1 - i]
	add	$t7, $t6, $t1
	lw	$t8, ($t7)			# int y = numbers[N_SIZE_M_1 - i];

	sw	$t8, ($t3)			# numbers[i] = y;
	sw	$t4, ($t7)			#  numbers[N_SIZE_M_1 - i] = x;

loop_increment:
	add	$t0, $t0, 1			# i++
	b	loop_cond

print:
	li	$t0, 0				# int i = 0

print_loop:
	bge	$t0, N_SIZE, print_end		# while (i < N_SIZE)

	la	$t1, numbers			# &numbers[i] = address of numbers + i * 4
	mul	$t2, $t0, 4
	add	$t3, $t2, $t1

	lw	$a0, ($t3)			# printf("%d", numbers[i])
	li	$v0, 1
	syscall

	li	$a0, ' '			# printf(" ")
	li	$v0, 11
	syscall

	add	$t0, $t0, 1			# i++
	b	print_loop

print_end:
	jr	$ra


# ##############################################################################
# Data Segment

        .data
numbers:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9