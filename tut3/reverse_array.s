# A short program that reverses an array by swapping elements.
# Note that since we end up using more registers, we need more documentation. 

# Constants


# ##############################################################################
# Code Segment

        .text

main:
	# initialise int i

# loop
	# loop for i < N_SIZE_D_2, then exit loop (i.e. increment loop)


	# calculate &numbers[i] = address of numbers + i * sizeof(numbers[i])


	# calculate &numbers[u] = address of numbers + u * sizeof(numbers[u])
	# where u = N_SIZE_M_1 - i


	# numbers[i] = y;
	# numbers[N_SIZE_M_1 - i] = x;


	# increment i and keep looping


# (optional) print the new array
#s syscall 1 & 11: print integer and character


	# return from main



# ##############################################################################
# Data Segment

        .data

# int numbers[N_SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
