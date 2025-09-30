# ##############################################################################
# Code Segment

	.text

main:
	# s = &string[0]; 
	la	$t0, string

	# intialise int length
	li	$t1, 0

loop:
	# loop until *s != '\0' then exit loop
	lb	$t2, ($t0)
	beq	$t2, '\0', end

	# increment length and s
	add	$t0, $t0, 1
	add	$t1, $t1, 1

	# keep looping
	b	loop

end:
	move	$a0, $t1
	li	$v0, 1
	syscall

	# return
	jr 	$ra


# ##############################################################################
# Data Segment

	.data
string:
	.asciiz "...."