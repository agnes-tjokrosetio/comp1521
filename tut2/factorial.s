# Computes factorials using no functions (except main)

# ##############################################################################
# Code Segment

        .text

main:
	# printf("n  = ");
	# syscall 4: print string

	la	$a0, input_str
	li	$v0, 4
	syscall

	# scanf("%d", n);
	# syscall 5: scan integer

	li	$v0, 5
	syscall
	move	$t0, $v0 # n

	# initialise fac, fac = 1

	li	$t1, 1

	# initialise i, i = 1

	li	$t2, 1

loop:
	# condition: loop for i <= n, then exit loop

	bgt	$t2, $t0, print

	# body: fac *= i

	mul	$t1, $t1, $t2

	# increment (: i++) and then loop back to condition

	add	$t2, $t2, 1
	b	loop

print:
	# printf("n! = ");
	# syscall 4: print string
	
	la	$a0, output_str
	li	$v0, 4
	syscall

	# printf("%d", fac);
	# syscall 1: print integer

	move	$a0, $t1
	li	$v0, 1
	syscall

	# printf("%c", '\n');
	# syscall 11: print character

	li	$a0, '\n'
	li	$v0, 11
	syscall


end:
	# return from main
        jr      $ra

# ##############################################################################
# Data Segment

        .data
input_str:
        .asciiz "n  = "
output_str:
        .asciiz "n! = "
newline_str:
        .asciiz "\n"