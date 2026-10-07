# Sum 4 numbers using function calls.

# ##############################################################################
# Code Segment

        .text

main:
	begin
	push	$ra

main_body:
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19
	jal	sum4			# int result = sum4(11, 13, 17, 19);

	move	$a0, $v0		# printf("%d\n", result);
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

main_epilogue:
	pop	$ra
	end

	li	$v0, 0			# return 0;
	jr	$ra


# ==============================================================================
# sum4 function
sum4:
	# a => $a0
	# b => $a1
	# c => $a2
	# d => $a3
	
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2

sum4_body:
	move	$s0, $a2
	move	$s1, $a3

	jal	sum2			# int res1 = sum2(a, b);
	move	$s2, $v0

	move	$a0, $s0		# int res2 = sum2(c, d);
	move	$a1, $s1
	jal	sum2

	move	$a0, $s2		# return sum2 (res1, res2);
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
	# int x => $a0
	# int y => $a1

	add	$v0, $a0, $a1		# x + y;

	jr	$ra			# return x + y;

