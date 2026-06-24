# Recursive maximum of array function

# ##############################################################################
# Code Segment

        .text

max:
	# Frame:    [$ra, $s0]   			=>  All the registers that are pushed and popped
	# Uses:     [$ra, $s0, $a0-1, $v0]		=>  Every register you have used
	# Clobbers: [$a0-1, $v0]			=>  Clobbers = Uses - Frame (registers that don't preserve values)
	#
	# Locals:           	=>  Variables defined or used in the function
	#   - $s0: int first element
	#   - $v0: int max_so_far
	#
	# Structure:        	=>  Labels you create
	#   max
	#   -> max__prologue
	#   -> max__body
	#        -> max__body_recurse
	#        -> max__body_so_far_condition
	#   -> max__epilogue
max__prologue:
	# create stack
	begin
	push 	$ra
	push	$s0

max__body:

	lw	$s0, ($a0)			# int first_element = array[0];

	bne	$a1, 1, max__body_recurse	# if (length == 1) {

	move	$v0, $s0
	j	max__epilogue			# return first_element;

max__body_recurse:

	add	$a0, $a0, 4
	sub	$a1, $a1, 1
	jal	max				# max(&array[1], length - 1);

	ble	$s0, $v0, max__epilogue		# if (first_element > max_so_far) {

max__body_so_far_condition:
	move	$v0, $s0			# max_so_far = first_element;

max__epilogue:
	pop	$s0
	pop	$ra
	end

	jr	$ra


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

