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


	# scanf("%d", x);
	# syscall 5: scan integer


# Note: take the negation of conditional statements

	# if (x > SQUARE_MAX)
	#     printf("square too big for 32 bits\n");
	#     syscall 4: print string


	# else
	#     y = x * x
	#     printf("%d\n", y);
	#     syscall 1: print integer
	#     syscall 11: print character


	# return from main


# ##############################################################################
# Data Segment

        .data
