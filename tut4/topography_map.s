# A topographic map!
# This helpful tool will tell explorers how much they need to climb to
# reach various points of interest.
#
# Given an array of points, `my_points`, it can look up individual cells
# in the 2D map and print their height.

# Constants
MAP_SIZE = 5
N_POINTS = 4

# Number of bytes of offset within the point2D struct, and its size in bytes
# Note that these can be really nice ways to simplify your calculations :)
ROW_OFFSET = 0
COL_OFFSET = 4
POINT2D_SZ = 8

# ##############################################################################
# Code Segment

        .text
main:
	# Registers:
	#   - $t0: int i, the loop counter
	#   - $t1: row of the current point
	#   - $t2: col of the current point
	#   - $t3: height of the current point
	#   - $t4: temporary result for array indexing
	#   - $t5: temporary result for array indexing

					# Loop over all elements, and print their data
points_loop_init:			# for (int i = 0; i < N_POINTS; i++) {
	li	$t0, 0			# $t0 = 0

points_loop_cond:
	bge	$t0, N_POINTS, points_loop_end	# if (i >= N_POINTS)

# TODO: Complete these three!
# int row = my_points[i].row;
# int col = my_points[i].col;
# int height = topography_grid[row][col];

	# calculate &my_points[i] = i * 8 + base address of my_points
	mul	$t1, $t0, 8
	la	$t2, my_points
	add	$t3, $t2, $t1

	# int row = my_points[i].row;
	# get my_points[i].row using the offset, ROW_OFFSET
	lw	$t4, ROW_OFFSET($t3)

	# int col = my_points[i].col;
	# get my_points[i].col using the offset, COL_OFFSET
	lw	$t5, COL_OFFSET($t3)

	# int height = topography_grid[row][col];
	# calculate &topography_grid[row][col]
	#           = base address of topography_grid + 4 * (row * MAP_SIZE + col)
	mul	$t6, $t4, MAP_SIZE
	add	$t6, $t6, $t5
	mul	$t6, $t6, 4

	lw	$t6, topography_grid($t6)
	
	# printf("Height at %d,%d=%d\n", row, col, height);

	li	$v0, 4			# $v0 = 4 (print string)
	la	$a0, height_str		# load address of height_str into $a0
	syscall				# print height_str

	li	$v0, 1			# $v0 = 1 (print int)
	move	$a0, $t4		# $a0 = row
	syscall				# print row

	li	$v0, 11			# $v0 = 11 (print ASCII character)
	li	$a0, ','		# $a0 = ','
	syscall				# print ','

	li	$v0, 1			# $v0 = 1 (print int)
	move	$a0, $t5		# $a0 = col
	syscall				# print col

	li	$v0, 11			# $v0 = 11 (print ASCII character)
	li	$a0, '='		# $a0 = '='
	syscall				# print '='

	li	$v0, 1			# $v0 = 1 (print int)
	move	$a0, $t6		# $a0 = height
	syscall				# print height

	li	$v0, 11			# $v0 = 11 (print ASCII character)
	li	$a0, '\n'		# $a0 = '\n'
	syscall				# print '\n'

points_loop_iter:
	addi	$t0, $t0, 1		# i++
	b	points_loop_cond	# branch to points_loop_cond

points_loop_end:

	jr	$ra			# return 0;

# ##############################################################################
# Data Segment

	.data

# 2D grid representing the height data for an area.
topography_grid:
	.word	0, 1, 1, 2, 3
	.word	1, 1, 2, 3, 4
	.word	1, 2, 3, 5, 7
	.word	3, 3, 4, 5, 6
	.word	3, 4, 5, 6, 7

# Points of interest to print heights for, as a 1D array of point2D_t structs.
# Note the memory layout of this array: each element requires 8 bytes, not 4.
my_points:
	.word	1, 2
	.word	2, 3
	.word	0, 0
	.word	4, 4

height_str: .asciiz "Height at "

