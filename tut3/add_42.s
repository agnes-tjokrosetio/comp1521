# A Short program that will load each element of an array, add 42 to it if it is a negative number, and then store it back if it was modified.


# Constant for the size of the array
N_SIZE = 10
NEW_SIZE = N_SIZE * 4

###################################################################
# Code Segment
        .text

main:

loop_init:
	li	$t0, 0				# int i = 0
loop_cond:
	bge	$t0, N_SIZE, loop_end		# while (i < N_SIZE)
loop_body:
	mul	$t2, $t0, 4			# &numbers[i] = address of numbers + i * 4
	lw	$t4, numbers($t2)

	bge	$t4, 0, loop_increment		# if (numbers[i] < 0)
	add	$t4, $t4, 42
	sw	$t4, numbers($t2) 		# numbers[i] += 42;

loop_increment:
	add	$t0, $t0, 1			# i++
	b	loop_cond

loop_end:
	li	$t0, 1				# int i = 0

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


###################################################################
# Data Segment

        .data
numbers:
	.word 0, 1, 2, -3, 4, -5, 6, -7, 8, 9