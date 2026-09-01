# Recursive maximum of array function

# ##############################################################################
# Code Segment

        .text

max:
	# Frame:    []   	=>  All the registers that are pushed and popped
	# Uses:     []		=>  Every register you have used
	# Clobbers: []		=>  Clobbers = Uses - Frame (registers that don't preserve values)
	#
	# Locals:           	=>  Variables defined or used in the function

	#
	# Structure:        	=>  Labels you create
	#   max
	#   -> max__prologue
	#   -> max__body
	#   -> max__epilogue
max__prologue:


max__body:


max__epilogue:



# main function (some testing code that calls the max function)
main:
main__prologue:
	push	$ra

main__body:
	la	$a0, array
	li	$a1, 10
	jal	max			# result = max(array, 10)

	move	$a0, $v0
	li	$v0, 1			# syscall 1: print_int
	syscall				# printf("%d", result)

	li	$a0, '\n'
	li	$v0, 11			# syscall 11: print_char
	syscall				# printf("%c", '\n');

	li	$v0, 0

main__epilogue:
	pop	$ra
	jr	$ra			# return 0;


# ##############################################################################
# Data Segment

	.data

array:
	.word 1, 2, 3, 4, 5, 6, 4, 3, 2, 1

