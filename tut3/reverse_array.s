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
	# initialise int i
	li	$t0, 0

loop:
	# loop for i < N_SIZE_D_2, then exit loop (i.e. increment loop)
	bge	$t0, N_SIZE_D_2, end

	# calculate &numbers[i] = address of numbers + i * sizeof(numbers[i])
	mul	$t1, $t0, 4
	la	$t2, numbers
	add	$t2, $t2, $t1

	lw	$t3, ($t2)

	# calculate &numbers[u] = address of numbers + u * sizeof(numbers[u])
	# where u = N_SIZE_M_1 - i
	la	$t4, numbers
	sub	$t5, N_SIZE_M_1, $t0
	mul	$t5, $t5, 4
	add	$t5, $t5, $t4

	lw	$t6, ($t5)

	# numbers[i] = y;
	# numbers[N_SIZE_M_1 - i] = x;
	sw 	$t6, ($t2)
	sw	$t3, ($t5)

	# increment i and keep looping
	add	$t0, $t0, 1
	b	loop

end:
# (optional) print the new array
#s syscall 1 & 11: print integer and character

	li	$t0, 0
print:
	bge	$t0, N_SIZE, return

	# la	$t1, numbers
	mul	$t2, $t0, 4
	# add	$t2, $t2, $t1
	
	lw	$a0, numbers($t2)
	li	$v0, 1
	syscall

	li	$v0, 11
	la	$a0, ' '
	syscall

	add	$t0, $t0, 1
	b	print

return:
	# return from main
	jr	$ra


# ##############################################################################
# Data Segment

        .data

# int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

numbers:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9