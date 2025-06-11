# Squares a number, unless it is too big for a 32-bit register.
# If it is too big, prints an error message instead.

# Constant
SQUARE_MAX = 46340

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

# Note: take the negation of conditional statements

	# if (x > SQUARE_MAX)
	#     printf("square too big for 32 bits\n");
	#     syscall 4: print string
	ble	$t0, SQUARE_MAX, print_square

	la	$a0, too_big_str
	li	$v0, 4
	syscall

	b	end

print_square:
	# else
	#     y = x * x
	#     printf("%d\n", y);
	#     syscall 1: print integer
	#     syscall 11: print character

	mul	$t0, $t0, $t0

	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

end:
	# return from main
        jr      $ra

# ##############################################################################
# Data Segment

        .data
prompt_str:
        .asciiz "Enter a number: "
too_big_str:
        .asciiz "square too big for 32 bits\n"