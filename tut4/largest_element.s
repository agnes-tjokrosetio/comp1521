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
	# create stack


max__body:
	# int first_element = array[0];


	# if (length = 1) go to base_case, otherwise do recurse


# PEDANTIC NOTE:
# For the assignment, when you create labels include the function section
# i.e. i have a label "method" in a function section "function__body" => "function__body_method"
max__body_base_case:
	# return first_element;


max__body_recurse:
	# int max_so_far = max(&array[1], length - 1);
	# get &array[1]; length - 1
	# call max function


	# if (first_element > max_so_far) max_so_far = first_element;


max__body_so_far:
	# return max_so_far;


max__epilogue:
	# clean up stack


	# return from max


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

