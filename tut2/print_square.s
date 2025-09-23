# Prints the square of a number

# ##############################################################################
# Code Segment

        .text

main:
        # printf("Enter a number: ");
	# syscall 4: print string
	li	$v0, 4
	la	$a0, prompt_str
	syscall

	# scanf("%d", x);
	# syscall 5: scan integer
	li	$v0, 5
	syscall
	# result will be in the register $v0

	# y = x * x
	mul	$a0, $v0, $v0

	# printf("%d", y);
	# syscall 1: print integer
	li 	$v0, 1
	syscall

	# printf("%c", '\n');
	# syscall 11: print character
	la	$a0, '\n'
	li	$v0, 11
	syscall

	# return from main
	jr	$ra

# ##############################################################################
# Data Segment

        .data

prompt_str:
	.asciiz "Enter a number: "