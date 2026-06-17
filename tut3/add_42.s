# A Short program that will load each element of an array, add 42 to it if it is a negative number, and then store it back if it was modified.


# Constant for the size of the array
N_SIZE = 10
NEW_SIZE = N_SIZE * 4

###################################################################
# Code Segment
        .text

main:

loop_init:
	li	$t0, 0

loop_cond:
	# bug: SIZE WAS INCORRECT (NEW SIZE SHOULD BE N_SIZE * 4)
	bge	$t0, NEW_SIZE, loop_end

loop_body:
	# method 1: &numbers[i]
	# la	$t1, numbers
	# mul	$t2, $t0, 4
	# add	$t2, $t2, $t1

	# method 2: &numbers[i]
	lw	$t3, numbers($t0)
	bge	$t3, 0, loop_step

	# numbers[i] += 42;
	add	$t3, $t3, 42

	# numbers[i] += 42;
	sw	$t3, numbers($t0) 

loop_step:
	# i++
	add	$t0, $t0, 4
	b	loop_cond

loop_end:


# PRINT LOOP 

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
        

###################################################################
# Data Segment

        .data
# int numbers[10] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};
numbers:
	.word 0, 1, 2, -3, 4, -5, 6, -7, 8, 9