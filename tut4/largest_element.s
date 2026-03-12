# Recursive maximum of array function

# ##############################################################################
# Code Segment

        .text

max:
	# Frame:    [$ra, $s0]   			=>  All the registers that are pushed and popped
	# Uses:     [$ra, $s0, $a0, $a1, $v0]		=>  Every register you have used
	# Clobbers: [$a0, $a1, $v0]			=>  Clobbers = Uses - Frame (registers that don't preserve values)
	#
	# Locals:           				=>  Variables defined or used in the function
	# - $s0: int first_element
	# - $v0: int max_so_far
	# - $a0: int array[], &array[1]
	# - $a1: int length, length - 1
	#
	# Structure:        				=>  Labels you create
	#   max
	#   -> max__prologue
	#   -> max__body
	#	-> max__body_base_case
	#	-> max__body_recurse
	#	-> max__body_so_far
	#   -> max__epilogue
max__prologue:
        begin					# create stack
        push    $ra
        push    $s0

max__body:
        lw      $s0, ($a0)			# int first_element = array[0];

        bne     $a1, 1, max__body_recurse 	# if (length = 1) go to base_case, otherwise do recurse

max__body_base_case:
        move    $v0, $s0			# return first_element;
        j       max__epilogue

max__body_recurse:
        add     $a0, $a0, 4			# int max_so_far = max(&array[1], length - 1);
        sub     $a1, $a1, 1
        jal     max

        ble     $s0, $v0, max__epilogue		# if (first_element > max_so_far) max_so_far = first_element;

max__body_so_far:
        move    $v0, $s0			# return max_so_far;

max__epilogue:
        pop     $s0				# clean up stack
        pop     $ra
        end

        jr      $ra				# return from max


# ==============================================================================
# main function (some testing code that calls the max function)
main:
main__prologue:
	begin				# create stack
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

main__epilogue:
	pop	$ra			# clean up stack
	end
	
	li	$v0, 0			# return 0;
	jr	$ra


# ##############################################################################
# Data Segment

	.data

array:
	.word 1, 2, 3, 4, 5, 6, 4, 3, 2, 1

