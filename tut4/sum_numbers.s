# Sum 4 numbers using function calls.

# ##############################################################################
# Code Segment

        .text

main:
	begin 
	push	$ra

	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19

main_body:

	jal	sum4			# int result = sum4(11, 13, 17, 19);

	move	$a0, $v0		# printf("%d", result);
	li	$v0, 1
	syscall

	li	$v0, 11			# printf("\n");
	li	$a0, '\n'
	syscall

epilogue:
	pop	$ra
	end

	jr	$ra			# return


# ==============================================================================
# sum4 function
sum4:
	# int a => $a0
	# int b	=> $a1
	# int c => $a2
	# int d => $a3

	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2

sum4_body:
	move	$s0, $a2	# save int c
	move	$s1, $a3	# save int d

	jal	sum2
	move	$s2, $v0	# int res1 = sum2(a, b);

	move	$a0, $s0
	move	$a1, $s1
	jal	sum2		# int res2 = sum2(c, d);

	move	$a0, $s2
	move	$a1, $v0
	jal	sum2		# sum2(res1, res2);

sum4_epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end

	jr	$ra		# return


# ==============================================================================
# sum2 function
sum2:
	# int x => $a0
	# int y => $a1

	add	$v0, $a0, $a1		# x + y

	jr	$ra			# return