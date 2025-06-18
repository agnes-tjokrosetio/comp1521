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
	bge	$t0, N_SIZE_D_2, print_loop
	
	# calculate &numbers[i] = address of numbers + i * sizeof(numbers[i])
	la	$t1, numbers
	mul	$t2, $t0, 4
	add	$t2, $t2, $t1

	lw	$t3, ($t2) #x

	# calculate &numbers[u] = address of numbers + u * sizeof(numbers[u])
	# where u = N_SIZE_M_1 - i
	sub	$t4, N_SIZE_M_1, $t0
	mul	$t4, $t4, 4
	add	$t4, $t4, $t1

	lw	$t5, ($t4) #y

	# (optional) print numbers[i] followed by a space
	# 	     syscall 1 & 11: print integer and character

	move	$a0, $t5
	li	$v0, 1
	syscall

	li	$a0, ' '
	li	$v0, 11
	syscall

	# numbers[i] = y;
	# numbers[N_SIZE_M_1 - i] = x;
	sw	$t5, ($t2)
	sw	$t3, ($t4)

	# increment i and keep looping
	add	$t0, $t0, 1
	b	loop

print_loop:

	li	$t0, 0

print_array:
	bge	$t0, N_SIZE, epilogue

	# (optional) print the new array
	# 	     syscall 1 & 11: print integer and character

	la	$t1, numbers
	mul	$t2, $t0, 4
	add	$t2, $t2, $t1

	lw	$t3, ($t2)

	move	$a0, $t3
	li	$v0, 1
	syscall

	li	$a0, ' '
	li	$v0, 11
	syscall

	add	$t0, $t0, 1
	b	print_array

epilogue:
	# return from main
        jr      $ra




# ##############################################################################
# Data Segment

        .data
numbers:
	# int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9