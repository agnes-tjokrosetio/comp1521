# Sum 4 numbers using function calls.

# ##############################################################################
# Code Segment

        .text

main:
	# create statck
	begin
	push	$ra

main_body:
	# load arguments
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19

	# int result = sum4(11, 13, 17, 19);
	jal	sum4

	# printf("%d", result);
	# syscall 1: print integer
	move	$a0, $v0
	li	$v0, 1
	syscall

	# printf("\n");
	# syscall 11: print character
	li	$a0, '\n'
	li	$v0, 11
	syscall


epilogue:
	# clean up stack
	pop	$ra
	end

	# return from main
        jr      $ra

# ==============================================================================
# sum4 function
sum4:

	# create the stack
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2

sum4_body:

	# save arguments a, b, c, d
	move	$s0, $a2
	move	$s1, $a3

	# int res1 = sum2(a, b);
	# a is in a0, and b is in a1
	jal	sum2
	move	$s2, $v0

	# int res2 = sum2(c, d);
	move	$a0, $s0
	move	$a1, $s1
	jal	sum2

	# return sum2(res1, res2);
	move	$a0, $s2
	move	$a1, $v0
	jal	sum2

sum4_epilogue:
	# clean up stack
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end

	# return from sum4
        jr      $ra


# ==============================================================================
# sum2 function
sum2:

	# return x + y;
	add	$v0, $a0, $a1

	# return from sum2
	jr	$ra
