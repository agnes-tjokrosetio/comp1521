# Squares a number, unless it is too big for a 32-bit register.
# If it is too big, prints an error message instead.

# Constant
SQUARE_MAX = 46340

# ##############################################################################
# Code Segment

        .text

main:
	# printf("Enter a number: ");
	li	$v0, 4
	la	$a0, prompt
	syscall

	# scanf("%d", &x);
	li	$v0, 5
	syscall
	move	$t0, $v0

	# if (x <= SQUARE_MAX)
	ble	$t0, SQUARE_MAX, print_square

	# printf("square too big for 32 bits\n");
	li	$v0, 4
	la	$a0, too_big
	syscall

	b	end

print_square:
	# y = x * x;
	mul	$t1, $t0, $t0

	# printf("%d\n", y);
	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

end:
	# return 0;
	li	$v0, 0
	jr	$ra


# ##############################################################################
# Data Segment

        .data
prompt:
	.asciiz "Enter a number: "

too_big:
	.asciiz "square too big for 32 bits\n"