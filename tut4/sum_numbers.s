# Sum 4 numbers using function calls.

# ##############################################################################
# Code Segment

        .text

main:
	# Frame:    [$ra]   			=>  All the registers that are pushed and popped
	# Uses:     [$ra, $a0 - $a3, $v0]	=>  Every register you have used
	# Clobbers: [$a0 - $a3, $v0]		=>  Clobbers = Uses - Frame (registers that don't preserve values)
	#
	# Locals:           			=>  Variables defined or used in the function
	# - $v0: int result
	#
	# Structure:        			=>  Labels you create
	#   main
	#   -> main_prologue
	#   -> main_body
	#   -> main_epilogue

main_prologue:
	# create stack
	begin
	push 	$ra

main_body:

	# int result = sum4(11, 13, 17, 19);
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19
	jal	sum4

	# printf("%d\n", result);
	move	$a0, $v0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall


main_epilogue:
	# clean up stack
	pop 	$ra
	end

	# return 0;
	li	$v0, 0
	jr 	$ra


# ==============================================================================
# sum4 function
sum4:
	# Frame:    [$ra, $s0 - $s2]   			=>  All the registers that are pushed and popped
	# Uses:     [$ra, $s0 - $s2, $a0 - $a3, $v0]	=>  Every register you have used
	# Clobbers: [$a0 - $a3, $v0]			=>  Clobbers = Uses - Frame (registers that don't preserve values)
	#
	# Locals:           				=>  Variables defined or used in the function
	# - $s2: int res1
	# - $v0: int res2
	# - $a0: int a , int c , res1
	# - $a1: int b , int d , res2
	# - $a2: int c
	# - $a3: int d
	#
	# Structure:        				=>  Labels you create
	#   sum4
	#   -> sum4_prologue
	#   -> sum4_body
	#   -> sum4_epilogue
sum4_prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2

sum4_body:
	# store int a, int b
	move	$s0, $a2
	move	$s1, $a3

	# int res1 = sum2(a, b);
	jal	sum2
	move	$s2, $v0 # res1

	# int res2 = sum2(c, d);
	move	$a0, $s0
	move	$a1, $s1
	jal	sum2 # res2

	# return sum2(res1, res2);
	move	$a0, $s2
	move	$a1, $v0
	jal	sum2

sum4_epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	
	end
	jr	$ra

# ==============================================================================
# sum2 function
sum2:

	# return x + y;
	add	$v0, $a0, $a1
	jr	$ra
