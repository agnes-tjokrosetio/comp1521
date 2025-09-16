# A Short program that will load each element of an array, add 42 to it if it is a negative number, and then store it back if it was modified.


# Constant for the size of the array
# This is treated like a literal (i.e. you load it with `li`, not `la/lb/lw`) but is more clear than a magic number
N_SIZE = 10


###################################################################
# Code Segment
        .text

main:
        # initialise int i


# loop
        # loop for i < N_SIZE, then exit loop (i.e. increment loop)


        # &numbers[i] = address of numbers + i * sizeof(numbers[i])


        # if (numbers[i] < 0) {
        #     numbers[i] += 42;
        # }


        # increment i and keep looping



# (optional) print the new array
#            syscall 1 & 11: print integer and character


        # return from main


###################################################################
# Data Segment


        .data
# int numbers[10] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};
