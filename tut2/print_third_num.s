# Prints every 3rd number from 24 to 42

# ##############################################################################
# Code Segment

        .text

main:

# initialise i (or whatever the counter is)
	li	$t0, 24 

loop:
# loop_condition: 
	# loop for i <= 42, then exit loop
	bge	$t0, 42, end

# loop_body:
	# printf("%d\n", x);
	# syscall 1: print integer
	# syscall 11: print character
	move	$a0, $t0

	li	$v0, 1
	syscall

	la	$a0, '\n'
	li	$v0, 11
	syscall

# loop_increment:
	# i += 3
	# loop back to condition
	add	$t0, $t0, 3
	b	loop

end:
# return from main
	jr	$ra
