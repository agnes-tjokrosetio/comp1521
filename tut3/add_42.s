# A Short program that will load each element of an array, add 42 to it if it is a negative number, and then store it back if it was modified.


# Constant for the size of the array
# This is treated like a literal (i.e. you load it with `li`, not `la/lb/lw`) but is more clear than a magic number
N_SIZE = 10

###################################################################
# Code Segment
        .text

main:

	li	$t0, 0

loop:
	bge	$t0, N_SIZE, end_loop

	# la	$t1, numbers
	mul	$t2, $t0, 4
	# add	$t2, $t2, $t1

	lw	$t3, numbers($t2)

	bge	$t3, 0, increment

	add	$t3, $t3, 42
	sw	$t3, numbers($t2)

increment:
	add	$t0, $t0, 1
	b	loop

end_loop:
# (optional) print the new array
#            syscall 1 & 11: print integer and character
	li	$t0, 0

print_loop:
	bge	$t0, 40, end

	# numbers[i]
	# la	$t1, numbers
	# mul	$t2, $t0, 4
	# add	$t2, $t2, $t1

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



###################################################################
# Data Segment


        .data
# int numbers[10] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};
numbers:
	.word 0, 1, 2, -3, 4, -5, 6, -7, 8, 9