# Prints the square of a number

# ##############################################################################
# Code Segment

        .text

main:
        # printf("Enter a number: ");
	# syscall 4: print string
	la	$a0, prompt_str
	li	$v0, 4
	syscall

	# scanf("%d", x);
	# syscall 5: scan integer
	li	$v0, 5
	syscall
	move	$t0, $v0

	# y = x * x
	mul	$t0, $t0, $t0

	# printf("%d", y);
	# syscall 1: print integer
	move	$a0, $t0
	li	$v0, 1
	syscall

	# printf("%c", '\n');
	# syscall 11: print character
	li	$a0, '\n'
	li	$v0, 11
	syscall

	# return from main
        jr      $ra

# ##############################################################################
# Data Segment

        .data

prompt_str:
	.asciiz "Enter a number: "