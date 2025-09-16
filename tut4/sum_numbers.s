# Sum 4 numbers using function calls.

# ##############################################################################
# Code Segment

        .text

main:
	# create statck


main_body:
	# load arguments


	# int result = sum4(11, 13, 17, 19);


	# printf("%d", result);
	# syscall 1: print integer


	# printf("\n");
	# syscall 11: print character



epilogue:
	# clean up stack


	# return from main


# ==============================================================================
# sum4 function
sum4:

	# create the stack


sum4_body:

	# save arguments a, b, c, d


	# int res1 = sum2(a, b);
	# a is in a0, and b is in a1


	# int res2 = sum2(c, d);


	# return sum2(res1, res2);


sum4_epilogue:
	# clean up stack


	# return from sum4


# ==============================================================================
# sum2 function
sum2:

	# return x + y;


	# return from sum2
