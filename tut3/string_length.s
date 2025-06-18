# ##############################################################################
# Code Segment

	.text

main:
	# s = &string[0]; 
	la	$t0, string

	# intialise int length
	li	$t1, 0

while:
	# loop until *s != '\0' then exit loop
	lb	$t2, ($t0)
	beq	$t2, '\0', end_loop

	# increment length and s
	add	$t0, $t0, 1
	add	$t1, $t1, 1

	# keep looping
	b	while

end_loop:
	
	# where is the length of string now?
	move	$a0, $t1
	li	$v0, 1
	syscall

	jr	$ra



# ##############################################################################
# Data Segment

	.data
string:
	.asciiz  "...."