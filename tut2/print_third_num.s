# Prints every 3rd number from 24 to 42

# ##############################################################################
# Code Segment

        .text

main:

loop_init:
# initialise i (or whatever the counter is)
	li	$t0, 24 # int i

loop:
# loop condition: 
	# loop for i <= 42, then exit loop
	
	bge	$t0, 42, epilogue

# loop body:
	# printf("%d" i);
	# syscall 1: print integer
	
	move	$a0, $t0
	li	$v0, 1
	syscall

	# printf("%c", '\n');
	# syscall 11: print character

	li	$a0, '\n'
	li	$v0, 11
	syscall


# loop increment
	# i += 3
	add	$t0, $t0, 3
	# loop back to condition
	b	loop


epilogue:
        jr      $ra             # return from main.