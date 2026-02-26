# Prints every 3rd number from 24 to 42
 ###################################################################
# Code Segment

        .text

main:
	# initialise i (or whatever the counter is)
        li      $t0, 24 # int i

loop:
	# loop condition:
        # loop for i <= 42, then exit loop	
        bge     $t0, 42, end

	# loop body:
        # printf("%d" i);
        move    $a0, $t0
        li      $v0, 1
        syscall

        # printf("%c", '\n');
        li      $a0, '\n'
        li      $v0, 11
        syscall

	# loop increment (: i += 3) and then loop back to condition
        add     $t0, $t0, 3
        b       loop

end:
	# return from main
        jr      $ra
