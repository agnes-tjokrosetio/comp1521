# Recursive maximum of array function

# ##############################################################################
# Code Segment

        .text

max:
	# Frame:    [$ra, $s0]   		=>  All the registers that are pushed and popped
	# Uses:     [$ra, $s0, $a0, $a1, $v0]	=>  Every register you have used
	# Clobbers: [$a0, $a1, $v0]		=>  Clobbers = Uses - Frame (registers that don't preserve values)
	#
	# Locals:           			=>  Variables defined or used in the function
	#   - $a0 : int array[]
	#   - $a1 : int length
	#   - $s0 : first_element
	#   - $v0 : max_so_far
	#
	# Structure:        			=>  Labels you create
	#   max
	#   -> max__prologue
	#       -> max__body
	# 	    -> max_base_case
	# 	    -> max_recurse
	# 	    -> max_so_far
	#   -> max__epilogue
max__prologue:
	# create stack
	begin
	push	$ra
	push	$s0

max__body:
	# int first_element = array[0];
	lw	$s0, ($a0)

	# if (length = 1) go to base_case, otherwise do recurse
	bne	$a1, 1, max__body_recurse

# PEDANTIC NOTE:
# For the assignment, when you create labels include the function section
# i.e. i have a label "method" in a function section "function__body" => "function__body_method"
max__body_base_case:
	# return first_element;
	move	$v0, $s0
	j	max__epilogue

max__body_recurse:
	# int max_so_far = max(&array[1], length - 1);
	# get &array[1]; length - 1
	# call max function
	add	$a0, $a0, 4
	sub	$a1, $a1, 1
	jal	max

	# if (first_element > max_so_far) max_so_far = first_element;
	ble	$s0, $v0, max__epilogue

max__body_so_far:
	# return max_so_far;
	move	$v0, $s0

max__epilogue:
	# clean up stack
	pop	$s0
	pop	$ra
	end

	# return from max
        jr      $ra


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

