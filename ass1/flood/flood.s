#######################################################################################
########################## COMP1521 25T2 ASSIGNMENT 1: Flood ##########################
##                                                                                   ##
## !!! IMPORTANT !!!                                                                 ##
## Before starting work on the assignment, make sure you set your tab-width to 8!    ##
## It is also suggested to indent with tabs only.                                    ##
## Instructions to configure your text editor can be found here:                     ##
##   https://cgi.cse.unsw.edu.au/~cs1521/current/resources/mips-editors.html         ##
## !!! IMPORTANT !!!                                                                 ##
##                                                                                   ##
## This program was written by JOHNNY DAI      (z5689865)                            ##
## on 25/06/25	                                                                     ##
##                                                                                   ##
## HEY! HEY YOU! Fill this header comment in RIGHT NOW!!! Don't miss out on that     ##
## precious style mark!!      >:O                                                    ##


########################################
## CONSTANTS: REQIURED FOR GAME LOGIC ##
########################################

TRUE = 1
FALSE = 0

UP_KEY = 'w'
LEFT_KEY = 'a'
DOWN_KEY = 's'
RIGHT_KEY = 'd'

FILL_KEY = 'e'

CHEAT_KEY = 'c'
HELP_KEY = 'h'
EXIT_KEY = 'q'

COLOUR_ONE = '='
COLOUR_TWO = 'x'
COLOUR_THREE = '#'
COLOUR_FOUR = '.'
COLOUR_FIVE = '*'
COLOUR_SIX = '`'
COLOUR_SEVEN = '@'
COLOUR_EIGHT = '&'

NUM_COLOURS = 8

MIN_BOARD_WIDTH = 3
MAX_BOARD_WIDTH = 12
MIN_BOARD_HEIGHT = 3
MAX_BOARD_HEIGHT = 12

BOARD_VERTICAL_SEPERATOR = '|'
BOARD_CROSS_SEPERATOR = '+'
BOARD_HORIZONTAL_SEPERATOR = '-'
BOARD_CELL_SEPERATOR = '|'
BOARD_SPACE_SEPERATOR = ' '
BOARD_CELL_SIZE = 3

SELECTED_ARROW_VERTICAL_LENGTH = 2

GAME_STATE_PLAYING = 0
GAME_STATE_LOST = 1
GAME_STATE_WON = 2

NUM_VISIT_DELTAS = 4
VISIT_DELTA_ROW = 0
VISIT_DELTA_COL = 1

MAX_SOLUTION_STEPS = 64

NOT_VISITED = 0
VISITED = 1
ADJACENT = 2

EXTRA_STEPS = 2

#################################################
## CONSTANTS: PLEASE USE THESE FOR YOUR SANITY ##
#################################################

SIZEOF_INT = 4
SIZEOF_PTR = 4
SIZEOF_CHAR = 1

##########################################################
## struct fill_in_progress {                            ##
##     int cells_filled;                                ##
##     char visited[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]; ##
##     char fill_with;                                  ##
##     char fill_onto;                                  ##
## };                                                   ##
##########################################################

CELLS_FILLED_OFFSET = 0
VISITED_OFFSET = CELLS_FILLED_OFFSET + SIZEOF_INT
FILL_WITH_OFFSET = VISITED_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR
FILL_ONTO_OFFSET = FILL_WITH_OFFSET + SIZEOF_CHAR

SIZEOF_FILL_IN_PROGRESS = FILL_ONTO_OFFSET + SIZEOF_CHAR

############################
## struct step_rating {   ##
##     int surface_area;  ##
##     int is_eliminated; ##
## };                     ##
############################

SURFACE_AREA_OFFSET = 0
IS_ELIMINATED_OFFSET = SURFACE_AREA_OFFSET + SIZEOF_INT

STEP_RATING_ALIGNMENT = 0

SIZEOF_STEP_RATING = IS_ELIMINATED_OFFSET + SIZEOF_INT + STEP_RATING_ALIGNMENT

###################################################################
## struct solver {                                               ##
##     struct step_rating step_rating_for_colour[NUM_COLOURS];   ##
##     int solution_length;                                      ##
##     char simulated_board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT];  ##
##     char future_board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT];     ##
##     char adjacent_to_cell[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]; ##
##     char optimal_solution[MAX_SOLUTION_STEPS];                ##
## };                                                            ##
###################################################################

STEP_RATING_FOR_COLOUR_OFFSET = 0
SOLUTION_LENGTH_OFFSET = STEP_RATING_FOR_COLOUR_OFFSET + SIZEOF_STEP_RATING * NUM_COLOURS
SIMULATED_BOARD_OFFSET = SOLUTION_LENGTH_OFFSET + SIZEOF_INT
FUTURE_BOARD_OFFSET = SIMULATED_BOARD_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR
ADJACENT_TO_CELL_OFFSET = FUTURE_BOARD_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR
OPTIMAL_SOLUTION_OFFSET = ADJACENT_TO_CELL_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR

SIZEOF_SOLVER = OPTIMAL_SOLUTION_OFFSET + MAX_SOLUTION_STEPS * SIZEOF_CHAR

###################
## END CONSTANTS ##
###################

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

######################
## GLOBAL VARIABLES ##
######################

	.data

###############################################
## char selected_arrow_horizontal[] = "<--"; ##
###############################################

selected_arrow_horizontal:
	.asciiz "<--"

##################################################
## char selected_arrow_vertical[] = {'^', '|'}; ##
##################################################

selected_arrow_vertical:
	.ascii "^|"

################################
## char cmd_waiting[] = "> "; ##
################################

cmd_waiting:
	.asciiz "> "

############################################################
## char colour_selector[NUM_COLOURS] = {                  ##
##    COLOUR_ONE, COLOUR_TWO, COLOUR_THREE, COLOUR_FOUR,  ##
##    COLOUR_FIVE, COLOUR_SIX, COLOUR_SEVEN, COLOUR_EIGHT ##
## };                                                     ##
############################################################

colour_selector:
	.byte COLOUR_ONE, COLOUR_TWO, COLOUR_THREE, COLOUR_FOUR
	.byte COLOUR_FIVE, COLOUR_SIX, COLOUR_SEVEN, COLOUR_EIGHT

#########################################################
## char game_board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]; ##
#########################################################

game_board:
	.align 2
	.space MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT

##################################################################
## int visit_deltas[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}; ##
##################################################################

visit_deltas:
	.word -1, 0
	.word 1, 0
	.word 0, -1
	.word 0, 1

#######################
## int selected_row; ##
#######################

selected_row:
	.align 2
	.space 4

##########################
## int selected_column; ##
##########################

selected_column:
	.align 2
	.space 4

######################
## int board_width; ##
######################

board_width:
	.align 2
	.space 4

#######################
## int board_height; ##
#######################

board_height:
	.align 2
	.space 4

################################################
## char optimal_solution[MAX_SOLUTION_STEPS]; ##
################################################

optimal_solution:
	.align 2
	.space MAX_SOLUTION_STEPS * SIZEOF_CHAR

########################
## int optimal_steps; ##
########################

optimal_steps:
	.align 2
	.space 4

######################
## int extra_steps; ##
######################

extra_steps:
	.align 2
	.space 4

################
## int steps; ##
################

steps:
	.align 2
	.space 4


#####################
## int game_state; ##
#####################

game_state:
	.align 2
	.space 4

###############################
## unsigned int random_seed; ##
###############################

random_seed:
	.align 2
	.space 4

######################################################
## struct fill_in_progress global_fill_in_progress; ##
######################################################

global_fill_in_progress:
	.align 2
	.space SIZEOF_FILL_IN_PROGRESS

##################################
## struct solver global_solver; ##
##################################

global_solver:
	.align 2
	.space SIZEOF_SOLVER

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

##########################
## END GLOBAL VARIABLES ##
##########################

####################
## STATIC STRINGS ##
####################

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

	.data

str_print_welcome_1:
	.asciiz "Welcome to flood!\n"

str_print_welcome_2:
	.asciiz "To move your cursor up/down, use "

str_print_welcome_3:
	.asciiz "To move your cursor left/right, use "

str_print_welcome_4:
	.asciiz "To see this message again, use "

str_print_welcome_5:
	.asciiz "To perform flood fill on the grid, use "

str_print_welcome_6:
	.asciiz "To cheat and see the 'optimal' solution, use "

str_print_welcome_7:
	.asciiz "To exit, use "


str_game_loop_win:
	.asciiz "You win!\n"

str_game_loop_lose:
	.asciiz "You lose :(\n"

str_initialise_game_enter_width:
	.asciiz "Enter the grid width: "

str_initialise_game_enter_height:
	.asciiz "Enter the grid height: "

str_initialise_game_invalid_width:
	.asciiz "Invalid width!\n"

str_initialise_game_invalid_height:
	.asciiz "Invalid height!\n"

str_initialise_game_enter_seed:
	.asciiz "Enter a random seed: "

str_do_fill_filled_1:
	.asciiz "Filled "

str_do_fill_filled_2:
	.asciiz " cells!\n"

str_print_board_steps:
	.asciiz " steps\n"

str_process_command_unknown:
	.asciiz "Unknown command: "

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

########################
## END STATIC STRINGS ##
########################


############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################

##############
## SUBSET 0 ##
##############

#####################
## int main(void); ##
#####################

################################################################################
# .TEXT <main>
	.text
main:
	# Subset:   0
	#
	# Frame:    [$ra]  
	# Uses:     [$v0]
	# Clobbers: [$v0]
	#
	# Locals:          
	#   - none
	#
	# Structure:        
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

main__prologue:
	begin
	push 	$ra
main__body:

	jal 	print_welcome
	jal 	initialise_game
	jal 	game_loop

main__epilogue:
	pop 	$ra
	end

	li 	$v0, 0
	jr	$ra

###########################
## void print_welcome(); ##
###########################

################################################################################
# .TEXT <print_welcome>
	.text
print_welcome:
	# Subset:   0
	#
	# Frame:    [$ra]  
	# Uses:     []
	# Clobbers: []
	#
	# Locals:         
	#   - none
	#
	# Structure:       
	#   print_welcome
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

print_welcome__prologue:
	begin
	push 	$ra
print_welcome__body:
	li 	$v0, 4
	la	$a0, str_print_welcome_1
	syscall

	la	$a0, str_print_welcome_2
	syscall
	li 	$v0, 11
	li 	$a0, UP_KEY
	syscall
	li 	$a0, '/'
	syscall
	li 	$a0, DOWN_KEY
	syscall
	li 	$a0, '\n'
	syscall

	li 	$v0, 4
	la	$a0, str_print_welcome_3
	syscall
	li 	$v0, 11
	li 	$a0, LEFT_KEY
	syscall
	li 	$a0, '/'
	syscall
	li 	$a0, RIGHT_KEY
	syscall
	li 	$a0, '\n'
	syscall

	li 	$v0, 4
	la	$a0, str_print_welcome_4
	syscall
	li 	$v0, 11
	li 	$a0, HELP_KEY
	syscall
	li 	$a0, '\n'
	syscall

	li 	$v0, 4
	la	$a0, str_print_welcome_5
	syscall
	li 	$v0, 11
	li 	$a0, FILL_KEY
	syscall
	li 	$a0, '\n'
	syscall

	li 	$v0, 4
	la	$a0, str_print_welcome_6
	syscall
	li 	$v0, 11
	li 	$a0, CHEAT_KEY
	syscall
	li 	$a0, '\n'
	syscall

	li 	$v0, 4
	la	$a0, str_print_welcome_7
	syscall
	li 	$v0, 11
	li 	$a0, EXIT_KEY
	syscall
	li 	$a0, '\n'
	syscall

print_welcome__epilogue:
	pop 	$ra
	end

	jr	$ra

##############
## SUBSET 1 ##
##############

#########################################################
## int in_bounds(int value, int minimum, int maximum); ##
#########################################################

################################################################################
# .TEXT <in_bounds>
	.text
in_bounds:
	# Subset:   1
	#
	# Frame:    [$ra]   
	# Uses:     [$a0, $a1, $a2, $v0]
	# Clobbers: [$a0, $a1, $a2, $v0]
	#
	# Locals:    
	#   - none
	#
	# Structure:     
	#   in_bounds
	#   -> [prologue]
	#       -> body
	#	-> return_0
	#   -> [epilogue]

in_bounds__prologue:
	begin
	push 	$ra
in_bounds__body:

	blt 	$a0, $a1, in_bounds__return_0
	bgt	$a0, $a2, in_bounds__return_0
	li 	$v0, 1
	b 	in_bounds__epilogue
in_bounds__return_0:
	li 	$v0, 0

in_bounds__epilogue:
	pop 	$ra
	end

	jr	$ra

#######################
## void game_loop(); ##
#######################

################################################################################
# .TEXT <game_loop>
	.text
game_loop:
	# Subset:   1
	#
	# Frame:    [$ra, $s0, $s1]  
	# Uses:     [$a0, $v0, $s0, $s1]
	# Clobbers: [$a0, $v0]
	#
	# Locals:       
	#   - $s0: address of game_board
	#   - $s1: value of game state
	#
	# Structure:      
	#   game_loop
	#   -> [prologue]
	#       -> body
	#	-> loop
	#		-> loop_start
	#		-> loop_end
	#	-> lost
	#   -> [epilogue]

game_loop__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
game_loop__body:
	la 	$s0, game_board
	move 	$a0, $s0
	jal 	print_board

game_loop__loop_start:
	lw 	$s1, game_state
	bne	$s1, GAME_STATE_PLAYING, game_loop__loop_end
	jal 	process_command
	b	game_loop__loop_start
game_loop__loop_end:
	beq 	$s1, GAME_STATE_LOST, game_loop__lost
	la 	$a0, str_game_loop_win
	li 	$v0, 4
	syscall
	b 	game_loop__epilogue
game_loop__lost:
	la 	$a0, str_game_loop_lose
	li 	$v0, 4
	syscall

game_loop__epilogue:
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

#############################
## void initialise_game(); ##
#############################

################################################################################
# .TEXT <initialise_game>
	.text
initialise_game:
	# Subset:   1
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$v0, $a0, $a1, $a2, $t0, $t1, $s0, $s1, $s2]
	# Clobbers: [$v0, $a0, $a1, $a2, $t0, $t1]
	#
	# Locals:           
	#   - $t0: address of destination
	#   - $t1: value to be moved
	#   - $s0: user_width
	#   - $s1: user_height
	#   - $s2: user_random_seed
	#
	# Structure:  
	#   initialise_game
	#   -> [prologue]
	#       -> body
	#	-> loop
	# 		-> start
	#		-> height
	#		-> end
	#   -> [epilogue]

initialise_game__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push 	$s2
initialise_game__body:
	li 	$s0, 0				# $s0 = user_width
	li 	$s1, 0				# $s1 = user_height
	li 	$s2, 0				# $s2 = user_random_seed

initialise_game__loop_start:
	li 	$a0, str_initialise_game_enter_width
	li 	$v0, 4
	syscall

	li 	$v0, 5
	syscall
	move 	$s0, $v0

	la 	$t0, board_width
	sw 	$s0, ($t0)			# board_width = user_width

	move 	$a0, $s0
	li 	$a1, MIN_BOARD_WIDTH
	li 	$a2, MAX_BOARD_WIDTH
	jal 	in_bounds

	beq 	$v0, 1, initialise_game__loop_height
	li 	$v0, 4
	la 	$a0, str_initialise_game_invalid_width
	syscall
	b 	initialise_game__loop_start

initialise_game__loop_height:
	li 	$v0, 4
	la 	$a0, str_initialise_game_enter_height
	syscall
	li 	$v0, 5
	syscall
	move 	$s1, $v0

	la 	$t0, board_height
	sw 	$s1, ($t0)

	move 	$a0, $s1
	li 	$a1, MIN_BOARD_HEIGHT
	li 	$a2, MAX_BOARD_HEIGHT
	jal 	in_bounds

	beq 	$v0, 1, initialise_game__loop_end
	li 	$v0, 4
	la 	$a0, str_initialise_game_invalid_height
	syscall
	b initialise_game__loop_start
initialise_game__loop_end:
	li 	$v0, 4
	la 	$a0, str_initialise_game_enter_seed 	# print "enter a random seed:"
	syscall

	li 	$v0, 5				# scanf -> &user_random_seed
	syscall
	move 	$s2, $v0

	la 	$t0, random_seed
	sw 	$s2, ($t0)			# random_seed = user_random_seed

	la	$t0, selected_row		# $t0 = address of destination
	li 	$t1, 0				# $t1 = data to be moved
	sw 	$t1, ($t0)

	la 	$t0, selected_column
	sw 	$t1, ($t0)

	la 	$t0, steps
	sw 	$t1, ($t0)

	li 	$t1, EXTRA_STEPS
	la 	$t0, extra_steps
	sw 	$t1, ($t0)

	li 	$t1, GAME_STATE_PLAYING
	la 	$t0, game_state
	sw 	$t1, ($t0)

	jal 	initialise_board
	jal 	find_optimal_solution

initialise_game__epilogue:
	pop 	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

#######################################################################
## int game_finished(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]); ##
#######################################################################

################################################################################
# .TEXT <game_finished>
	.text
game_finished:
	# Subset:   1
	#
	# Frame:    [$ra, $s0, $s1]  
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $s0, $s1]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6]
	#
	# Locals:       
	#   - $t0: address of board
	#   - $t1: row 
	#   - $t2: col
	#   - $t3: max board width
	#   - $t4: offset, offset + address
	#   - $t5: colour of tile after offset
	#   - $t6: expected colour (board[0][0])
	#   - $s0: board_height
	#   - $s1: board_width

	# Structure:    
	#   game_finished
	#   -> [prologue]
	#       -> body
	#	-> outer
	#		-> init
	#		-> cond
	#		-> body
	#		-> inner
	#			-> init
	#			-> cond
	#			-> body
	#			-> step
	#		-> step
	#		-> end
	#   -> [epilogue]

game_finished__prologue:
	begin 	
	push 	$ra
	push 	$s0
	push 	$s1
game_finished__body:
	move 	$t0, $a0				# $t0 = &board[0][0]
	lb 	$t6, ($a0)				# $t6 = expected_colour
game_finished__outer_init:
	li 	$t1, 0					# $t1 = int row = 0
game_finished__outer_cond:
	lw 	$s0, board_height			# $s0 = board_height
	bge	$t1, $s0, game_finished__outer_end
game_finished__outer_body:
	li 	$t2, 0					# $t2 = int col = 0
game_finished__inner_cond:
	lw 	$s1, board_width			# $s1 = board_width
	bge 	$t2, $s1, game_finished__outer_step
game_finished__inner_body:
	mul 	$t4, MAX_BOARD_WIDTH, $t1		# $t4 = row * N_COLS
	add 	$t4, $t4, $t2				# $t4 = row * N_COLS + col
	add 	$t4, $t0, $t4				# $t4 = &board[row][col]

	move	$a0, $t4
	li	$v0, 1
	syscall

	lb 	$t5, ($t4)				# $t5 = current tile colour

	beq 	$t5, $t6, game_finished__inner_step
	li 	$v0, FALSE
	b 	game_finished__epilogue

game_finished__inner_step:
	addi 	$t2, $t2, 1
	b 	game_finished__inner_cond
game_finished__outer_step:
	addi 	$t1, $t1, 1
	b 	game_finished__outer_cond
game_finished__outer_end:
	li 	$v0, TRUE

game_finished__epilogue:
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

#####################
## void do_fill(); ##
#####################

################################################################################
# .TEXT <do_fill>
	.text
do_fill:
	# Subset:   1
	#
	# Frame:    [$ra, $s0, $s1]   <-- FILL THESE OUT!
	# Uses:     [$v0, $a0, $a1, $a2, $a3, $t0, $t1, $t2, $t3, $t4, $t5, $s0, $s1]
	# Clobbers: [$v0, $a0, $a1, $a2, $a3, $t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t0: selected_row, game_finished(game_board)
	#   - $t1: selected_column, global_fill_in_progress.cells_filled, steps, &game_state
	#   - $t2: offset, optimal_steps, optimal_steps + extra_steps, GAME_STATE_WON
	#   - $t3: pos in game_board, steps, steps++, extra_steps
	#   - $t4: game_board offset value, &game_board, &game_state
	#   - $t5: board[0][0], GAME_STATE_LOST
	#   - $s0: address of global_fill_in_progress
	#   - $s1: address of game_board
	#
	# Structure:        <-- FILL THIS OUT!
	#   do_fill
	#   -> [prologue]
	#       -> body
	#	-> win_check_again
	#	-> win
	#	-> lose
	#   -> [epilogue]

do_fill__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
do_fill__body:
	la 	$s0, global_fill_in_progress		# &global_fill_in_progress

	lw 	$t0, selected_row
	lw 	$t1, selected_column
	li 	$t2, MAX_BOARD_WIDTH
	mul 	$t2, $t0, $t2
	add 	$t2, $t2, $t1				# offset for selected_row + col
	
	la 	$s1, game_board				# &game_board
	add	$t3, $t2, $s1
	lb 	$t4, ($t3)				# game_board(selected_offset)

	lb 	$t5, ($s1)				# board[0][0]

	move 	$a0, $s0
	move 	$a1, $t4
	move 	$a2, $t5

	jal 	initialise_fill_in_progress

	move 	$a0, $s0
	move 	$a1, $s1
	li 	$a2, 0
	li 	$a3, 0

	jal 	fill

	li 	$v0, 4
	la 	$a0, str_do_fill_filled_1
	syscall
		
	lw 	$t1, global_fill_in_progress		# cells_filled
	move 	$a0, $t1
	li 	$v0, 1
	syscall

	la 	$a0, str_do_fill_filled_2
	li 	$v0, 4
	syscall

	lw 	$t3, steps
	addi 	$t3, $t3, 1
	sw 	$t3, steps

	la 	$t4, game_board
	move 	$a0, $t4
	
	jal 	game_finished
	
	move 	$t0, $v0				# game_finished(game_board)
	beq 	$t0, 1, do_fill__win
do_fill__win_check_again:
	lw 	$t1, steps
	lw 	$t2, optimal_steps
	lw 	$t3, extra_steps

	add 	$t2, $t2, $t3				# optimal_steps + extra_steps
	bgt 	$t1, $t2, do_fill__lose

	b 	do_fill__epilogue
do_fill__win:
	la 	$t1, game_state
	li 	$t2, GAME_STATE_WON
	sw 	$t2, ($t1)
	b 	do_fill__win_check_again
do_fill__lose:
	la 	$t4, game_state
	li 	$t5, GAME_STATE_LOST
	sw 	$t5, ($t4)
	b 	do_fill__epilogue
do_fill__epilogue:
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

##############
## SUBSET 2 ##
##############

########################################################################
## void initialise_fill_in_progress(struct fill_in_progress *init_me, ## 
##     char fill_with, char fill_onto);                               ##
########################################################################

################################################################################
# .TEXT <initialise_fill_in_progress>
	.text
initialise_fill_in_progress:
	# Subset:   2
	#
	# Frame:    [$ra]   
	# Uses:     [$v0, $a0, $a1, $a2, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8]
	# Clobbers: [$v0, $a0, $a1, $a2, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8]
	#
	# Locals:         
	#   - $t0: pointer to init_me (address)
	#   - $t1: colour to fill_with
	#   - $t2: colour to fill_onto
	#   - $t3: zero
	#   - $t4: row
	#   - $t5: col
	#   - $t6: offset using row and col
	#   - $t7: offset + address
	#   - $t8: holds NOT_VISITED 
	#
	# Structure:    
	#   initialise_fill_in_progress
	#   -> [prologue]
	#       -> body
	#	-> outer
	#		-> init
	#		-> cond
	#		-> body
	#		-> inner
	#			-> init
	#			-> cond
	#			-> body
	#			-> step
	#		-> step
	#   -> [epilogue]

initialise_fill_in_progress__prologue:
	begin
	push 	$ra
	push	$s0
	push 	$s1
initialise_fill_in_progress__body:
	move 	$t0, $a0			# $t0 = *init_me
	move 	$t1, $a1			# $t1 = fill_with
	move 	$t2, $a2			# $t2 = fill_onto
	
	sb 	$t1, FILL_WITH_OFFSET($t0)			# init_me->fill_with = fill_with
	sb 	$t2, FILL_ONTO_OFFSET($t0)			# init_me->fill_onto = fill_onto
	li 	$t3, 0
	sw 	$t3, ($t0)			# cells_filled = 0

	lw 	$s0, board_height
	lw 	$s1, board_width
initialise_fill_in_progress__outer_init:
	li 	$t4, 0				# $t4 = row = 0
initialise_fill_in_progress__outer_cond:
	bge	$t4, $s0, initialise_fill_in_progress__epilogue
initialise_fill_in_progress__outer_body:
	li 	$t5, 0 				# $t5 = col = 0
initialise_fill_in_progress__inner_cond:
	bge 	$t5, $s1, initialise_fill_in_progress__outer_step
initialise_fill_in_progress__inner_body:
	mul 	$t6, $t4, MAX_BOARD_WIDTH	# $t6 = row * N_COL
	add 	$t6, $t6, $t5			# $t6 = row * N_COL + col = offset
	addi 	$t6, VISITED_OFFSET			# skips cells_filled
	add 	$t7, $t0, $t6			# offset address

	li 	$t8, NOT_VISITED
	sb 	$t8, ($t7)
initialise_fill_in_progress__inner_step:
	addi 	$t5, 1
	b 	initialise_fill_in_progress__inner_cond
initialise_fill_in_progress__outer_step:
	addi 	$t4, 1
	b 	initialise_fill_in_progress__outer_cond
initialise_fill_in_progress__epilogue:
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end
	
	jr	$ra

##############################
## void initialise_board(); ##
##############################

################################################################################
# .TEXT <initialise_board>
	.text
initialise_board:
	# Subset:   2
	#
	# Frame:    [$ra, $s0, $s1]   
	# Uses:     [$v0, $a0, $a1, $t0, $t1, $t2, $t3, $t4, $s0, $s1]
	# Clobbers: [$v0, $a0, $a1, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $s0: row
	#   - $s1: col
	#   - $t0: holds NUM_COLOURS
	#   - $t1: address of game_board
	#   - $t2: offset value for game_board, offset address for game_board 
	#   - $t3: offset value for colour selector, offset address for colour selector
	#   - $t4: holds value for colour selector at colour_selector_index
	#
	# Structure:     
	#   initialise_board
	#   -> [prologue]
	#       -> body
	#	-> outer
	#		-> cond
	#		-> body
	#		-> inner
	#			-> init
	#			-> cond
	#			-> body
	#			-> step
	#		-> step
	#   -> [epilogue]

initialise_board__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
initialise_board__body:
	li 	$s0, 0				# $s0 = row = 0
initialise_board__outer_cond:
	bge	$s0, MAX_BOARD_HEIGHT, initialise_board__epilogue
initialise_board__outer_body:
	li 	$s1, 0 				# $s1 = col = 0
initialise_board__inner_cond:
	bge 	$s1, MAX_BOARD_WIDTH, initialise_board__outer_step
initialise_board__inner_body:
	li 	$a0, 0
	li 	$t0, NUM_COLOURS
	addi 	$a1, $t0, -1
	jal 	random_in_range

	move 	$t0, $v0			# colour_selector_index = random_in_range(0, NUM_COLOURS - 1)

	la 	$t1, game_board
	mul 	$t2, $s0, MAX_BOARD_WIDTH	# $t2 = row * N_COL
	add 	$t2, $t2, $s1 			# $t2 = row * N_COL + col = offset value
	add 	$t2, $t2, $t1			# $t2 = offset address for game_board

	la 	$t3, colour_selector
	add 	$t3, $t3, $t0			# $t3 = offset address for colour_selector
	lb 	$t4, ($t3)			# $t4 = colour_selector(colour_selector_index)

	sb 	$t4, ($t2)
initialise_board__inner_step:
	addi 	$s1, 1
	b 	initialise_board__inner_cond
initialise_board__outer_step:
	addi 	$s0, 1
	b 	initialise_board__outer_cond

initialise_board__epilogue:
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

###################################
## void find_optimal_solution(); ##
###################################

################################################################################
# .TEXT <find_optimal_solution>
	.text
find_optimal_solution:
	# Subset:   2
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3] 
	# Uses:     [$v0, $a0, $a1, $a2, $t0, $t1, $t2, $s0, $s1, $s2, $s3]
	# Clobbers: [$v0, $a0, $a1, $a2, $t0, $t1, $t2]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t0: global_solver.simulated_board, address of optimal_solution offset by global_solver.solution_length
	#   - $t1: holds '\0'
	#   - $t2: address of optimal steps
	#   - $s0: address of global_solver
	#   - $s1: address of optimal_solution
	#   - $s2: address of global_solver.solution_length
	#   - $s3: value of global_solver.solution_length
	#
	# Structure:        <-- FILL THIS OUT!
	#   find_optimal_solution
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

find_optimal_solution__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push 	$s2
	push 	$s3
find_optimal_solution__body:
	la 	$s0, global_solver			# &global_solver
	move 	$a0, $s0
	jal 	initialise_solver

find_optimal_solution__loop_start:
	add 	$t0, $s0, SIMULATED_BOARD_OFFSET	# &global_solver.simulated_board
	move 	$a0, $t0
	jal	game_finished

	beq 	$v0, 1, find_optimal_solution__loop_end

	move 	$a0, $s0
	jal 	solve_next_step
	b 	find_optimal_solution__loop_start
find_optimal_solution__loop_end:
	add 	$a0, $s0, OPTIMAL_SOLUTION_OFFSET	# offset address for global_solver.optimal_sol
	la 	$s1, optimal_solution			# &optimal_solution
	add 	$s2, $s0, SOLUTION_LENGTH_OFFSET	# &global_solver.solution_length
	lw 	$a2, ($s2)				# solution length
	move 	$s3, $a2				# sol len

	move 	$a1, $s1
	jal 	copy_mem

	add 	$t0, $s1, $s3				# &optimal_solution[global_solver.solution_length]
	li 	$t1, '\0'
	sb 	$t1, ($t0)

	la 	$t2, optimal_steps
	sw 	$s3, ($t2)
find_optimal_solution__epilogue:
	pop 	$s3
	pop 	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end
	
	jr	$ra

################################################################
## int invalid_step(struct solver *solver, int colour_index); ##
################################################################

################################################################################
# .TEXT <invalid_step>
	.text
invalid_step:
	# Subset:   2
	#
	# Frame:    [$ra, $s0, $s1, $s2] 
	# Uses:     [$v0, $a0, $a1, $s0, $s1, $s2, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8]
	# Clobbers: [$v0, $a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8]
	#
	# Locals:    
	#   - $s0: address to solver
	#   - $s1: int colour_index
	#   - $s2: int found = FALSE
	#   - $t0: &solver->simulated_board[0][0], board_height, solver->simulated_board[0][0]
	#   - $t1: &colour_selector[colour_index], board_width, colour_selector[colour_index]
	#   - $t2: row
	#   - $t3: col
	#   - $t4: &solver->simulated_board[0][0]
	#   - $t5: offset, &solver->simulated_board[row][col], value of solver->simulated_board[row][col]
	#   - $t6: &colour_selector[colour_index], colour_selector[colour_index]
	#   - $t7: &solver->adjacent_to_cell[0][0]
	#   - $t8: &solver->adjacent_to_cell[row][col], solver->adjacent_to_cell[row][col]
	#
	# Structure:     
	#   invalid_step
	#   -> [prologue]
	#       -> body
	#	-> outer
	#		-> cond
	#		-> body
	#		-> inner
	#			-> init
	#			-> cond
	#			-> body
	#			-> step
	#		-> step
	#		-> end
	#	-> ret_false
	#	-> ret_true
	#   -> [epilogue]

invalid_step__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push 	$s2
invalid_step__body:
	move 	$s0, $a0					# &solver
	move 	$s1, $a1					# colour_index

	add 	$t0, $s0, SIMULATED_BOARD_OFFSET		# &solver->simulated_board[0][0]
	lb 	$t0, ($t0)
	la 	$t1, colour_selector
	add 	$t1, $t1, $s1					# &colour_selector[colour_index]
	lb 	$t1, ($t1)

	beq 	$t0, $t1, invalid_step__ret_true


	jal 	initialise_solver_adjacent_cells

	move 	$a0, $s0
	li 	$a1, 0
	li 	$a2, 0
	jal 	find_adjacent_cells

	li 	$s2, FALSE					# int found = FALSE
	lw 	$t0, board_height
	lw 	$t1, board_width
invalid_step__outer_init:
	li 	$t2, 0						# $t2 = row = 0
invalid_step__outer_cond:
	bge	$t2, $t0, invalid_step__outer_end
invalid_step__outer_body:
	li 	$t3, 0 						# $t3 = col = 0
invalid_step__inner_cond:
	bge 	$t3, $t1, invalid_step__outer_step
invalid_step__inner_body:
	add 	$t4, $s0, SIMULATED_BOARD_OFFSET		# &solver->simulated_board[0][0]
	mul 	$t5, $t2, MAX_BOARD_WIDTH			# row * MAX_COLS
	add 	$t5, $t5, $t3					# row * MAX_COLS + col
	add 	$t5, $t4, $t5					# &solver->simulated_board[row][col]
	lb 	$t5, ($t5)

	la 	$t6, colour_selector
	add 	$t6, $t6, $s1
	lb 	$t6, ($t6)					# colour_selector[colour_index]

	bne 	$t5, $t6, invalid_step__inner_step

	add 	$t7, $s0, ADJACENT_TO_CELL_OFFSET
	mul	$t8, $t2, MAX_BOARD_WIDTH
	add	$t8, $t8, $t3
	add 	$t8, $t7, $t8
	lb 	$t8, ($t8)

	bne 	$t8, ADJACENT, invalid_step__inner_step

	li 	$s2, TRUE

invalid_step__inner_step:
	addi 	$t3, 1
	b 	invalid_step__inner_cond
invalid_step__outer_step:
	addi 	$t2, 1
	b 	invalid_step__outer_cond
invalid_step__outer_end:
	beq 	$s2, TRUE, invalid_step__ret_false
	b 	invalid_step__ret_true

invalid_step__ret_false:
	li 	$v0, FALSE
	b	invalid_step__epilogue
invalid_step__ret_true:
	li 	$v0, TRUE
invalid_step__epilogue:
	pop	$s2
	pop	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

####################################
## void print_optimal_solution(); ##
####################################

################################################################################
# .TEXT <print_optimal_solution>
	.text
print_optimal_solution:
	# Subset:   2
	#
	# Frame:    [$ra]  
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t0: ptr to optimal_solution
	#   - $t1: 
	#   - $t2: 
	#   - $t3: 
	#   - $t4: 
	#
	# Structure:        <-- FILL THIS OUT!
	#   print_optimal_solution
	#   -> [prologue]
	#       -> body
	#	-> loop1
	#		-> start
	#		-> if
	#		-> end
	#	-> loop2
	#		-> start
	#		-> if
	#		-> if_end
	#   -> [epilogue]

print_optimal_solution__prologue:
	begin
	push 	$ra
print_optimal_solution__body:
	la 	$t0, optimal_solution					# s = optimal_solution

print_optimal_solution__loop1_start:
	lb 	$t1, ($t0)						# $t1 = *s
	beq 	$t1, 0, print_optimal_solution__loop1_end	

	li 	$v0, 11
	move 	$a0, $t1
	syscall

	addi 	$t0, 1

	lb 	$t1, ($t0)
	bne 	$t1, 0, print_optimal_solution__loop1_if

	li 	$v0, 11
	li 	$a0, '\n'
	syscall
	b 	print_optimal_solution__loop1_start
print_optimal_solution__loop1_if:
	li 	$v0, 11
	li	$a0, ','
	syscall
	li 	$a0, ' '
	syscall
	b 	print_optimal_solution__loop1_start
print_optimal_solution__loop1_end:

	la 	$t0, optimal_solution					# $t0 = &optimal_solution
	li 	$t1, 0							# $t1 = i = 0

	lw 	$t2, steps						# $t2 = steps
	lw 	$t3, optimal_steps					# $t3 = optimal_steps
	ble	$t2, $t3, print_optimal_solution__loop2_start		

	li 	$v0, 11
	li 	$a0, 10
	syscall
	b 	print_optimal_solution__epilogue				

print_optimal_solution__loop2_start:
	lb 	$t3, ($t0)						# $t3 = *s
	beq 	$t3, 0, print_optimal_solution__epilogue

	beq 	$t1, $t2, print_optimal_solution__loop2_if
	
	li 	$v0, 11
	li 	$a0, ' '
	syscall
	b 	print_optimal_solution__loop2_if_end
print_optimal_solution__loop2_if:
	li 	$v0, 11
	li 	$a0, '^'
	syscall

print_optimal_solution__loop2_if_end:
	li 	$a0, ' '
	syscall
	syscall

	addi 	$t0, 1
	addi 	$t1, 1

	lb 	$t4, ($t0)
	bne 	$t4, 0, print_optimal_solution__loop2_start
	li 	$a0, '\n'
	syscall
	b 	print_optimal_solution__loop2_start

print_optimal_solution__epilogue:
	pop 	$ra
	end
	
	jr	$ra

##############
## SUBSET 3 ##
##############

################################################################
## void rate_choice(struct solver *solver, int colour_index); ##
################################################################

################################################################################
# .TEXT <rate_choice>
	.text
rate_choice:
	# Subset:   3
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7] 
	# Uses:     [$a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7]
	# Clobbers: [$a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:       
	#   - $t0: solver->step_rating_for_colour[colour_index].is_eliminated
	#   - $t1: solver->step_rating_for_colour[colour_index].surface_area
	#   - $t2: solver->simulated_board[row][col]
	#   - $t3: colour_selector[colour_index]
	#   - $t4: solver->adjacent_to_cell[row][col]
	#   - $t5: tmp (TRUE/FALSE register)
	#   - $s0: &solver
	#   - $s1: int colour_index
	#   - $s2: int seen
	#   - $s3: board_height
	#   - $s4: board_width
	#   - $s5: row
	#   - $s6: col
	#   - $s7: row/col offset
	#
	# Structure:        
	#   rate_choice
	#   -> [prologue]
	#	-> body
	#	-> outer
	#		-> cond
	#		-> body
	#		-> inner
	#			-> init
	#			-> cond
	#			-> body
	#			-> body_secondif
	#			-> body_elseif
	#			-> step
	#		-> step
	#		-> end
	#   -> [epilogue]

rate_choice__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push	$s2
	push 	$s3
	push 	$s4
	push	$s5
	push	$s6
	push	$s7
rate_choice__body:
	move 	$s0, $a0				# $s0 = &solver 
	move 	$s1, $a1				# $s1 = int colour_index

	mul 	$t0, $s1, SIZEOF_STEP_RATING
	add 	$t0, $s0, $t0				# 
	addi 	$t0, $t0, IS_ELIMINATED_OFFSET		# $t0 = &solver->step_rating_for_colour[colour_index].is_eliminated
	li 	$t1, TRUE
	sw 	$t1, ($t0)				# solver->step_rating_for_colour[colour_index].is_eliminated = TRUE;

	sub 	$t1, $t0, IS_ELIMINATED_OFFSET		# $t1 = &solver->step_rating_for_colour[colour_index].surface_area
	li 	$t2, 0					#
	sw 	$t2, ($t1)				# solver->step_rating_for_colour[colour_index].surface_area = 0;

	li 	$s2, FALSE				# $s2 = int seen = FALSE


	lw 	$s3, board_height			# $s3 = board_height
	lw 	$s4, board_width			# $s4 = board_width
	li 	$s5, 0					# $s5 = row = 0
rate_choice__outer_cond:
	bge	$s5, $s3, rate_choice__outer_end	# if (row >= board_height) goto rate_choice__outer_end
rate_choice__outer_body:
	li 	$s6, 0 					# $s6 = col = 0
rate_choice__inner_cond:
	bge 	$s6, $s4, rate_choice__outer_step	# if (col >= board_width) goto rate_choice__outer_step
rate_choice__inner_body:
	add 	$t2, $s0, SIMULATED_BOARD_OFFSET	# &solver->simulated_board

	mul 	$t3, $s5, MAX_BOARD_WIDTH
	add 	$t3, $t3, $s6				# row/col offset
	move 	$s7, $t3				# $s7 = row/col offset
	add 	$t2, $t2, $t3				# &solver->simulated_board[row][col]
	lb 	$t2, ($t2)				# $t2 = solver->simulated_board[row][col]

	la 	$t3, colour_selector			# $t3 = &colour_selector
	add 	$t3, $t3, $s1				# $t3 = &colour_selector[colour_index]
	lb 	$t3, ($t3)				# $t3 = colour_selector[colour_index]
	
	bne 	$t2, $t3, rate_choice__inner_body_secondif

	li 	$s2, TRUE				# seen = TRUE;
rate_choice__inner_body_secondif:
	add 	$t4, $s0, ADJACENT_TO_CELL_OFFSET	# $t4 = &solver->adjacent_to_cell
	add 	$t4, $s7				# $t4 = &solver->adjacent_to_cell[row][col]
	lb 	$t4, ($t4)				# $t4 = solver->adjacent_to_cell[row][col]

	bne 	$t4, NOT_VISITED, rate_choice__inner_body_elseif

	li 	$t5, FALSE				# $t5 = FALSE
	sw 	$t5, ($t0)				# solver->step_rating_for_colour[colour_index].is_eliminated = FALSE;
	b 	rate_choice__inner_step
rate_choice__inner_body_elseif:
	bne 	$t4, ADJACENT, rate_choice__inner_step
	lw 	$t5, ($t1)				# $t5 = solver->step_rating_for_colour[colour_index].surface_area
	addi 	$t5, 1					# $t5++
	sw 	$t5, ($t1)				# 

rate_choice__inner_step:
	addi 	$s6, 1					# col++
	b 	rate_choice__inner_cond
rate_choice__outer_step:
	addi 	$s5, 1					# row++
	b 	rate_choice__outer_cond
rate_choice__outer_end:

	bne 	$s2, FALSE, rate_choice__epilogue	
	li 	$t5, FALSE
	sw 	$t5, ($t0)				# solver->step_rating_for_colour[colour_index].is_eliminated = FALSE;

rate_choice__epilogue:
	pop	$s7
	pop	$s6
	pop 	$s5
	pop 	$s4
	pop 	$s3
	pop	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

########################################################################
## void find_adjacent_cells(struct solver *solver, int row, int col); ##
########################################################################

################################################################################
# .TEXT <find_adjacent_cells>
	.text
find_adjacent_cells:
	# Subset:   3
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4]  
	# Uses:     [$v0, $a0, $a1, $a2, $s0, $s1, $s2, $s3, $s4, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8]
	# Clobbers: [$v0, $a0, $a1, $a2, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8]
	#
	# Locals:       
	#   - $t0: fill_region_colour = solver->simulated_board[0][0], row + row_delta, col + col_delta, ADJACENT
	#   - $t1: row * N_COLS + col = offset, board_height - 1, col + col_delta
	#   - $t2: &adjacent_to_cell[row][col]
	#   - $t3: adjacent_to_cell[row][col]
	#   - $t4: solver->simulated_board[row][col]
	#   - $t5: VISITED
	#   - $t6: int i
	#   - $t7: row_delta offset
	#   - $t8: col_delta offset
	#   - $s0: &solver
	#   - $s1: row
	#   - $s2: col
	#   - $s3: row_delta = visit_deltas[i][VISIT_DELTA_ROW]
	#   - $s4: col_delta = visit_deltas[i][VISIT_DELTA_COL]
	#
	# Structure:        <-- FILL THIS OUT!
	#   find_adjacent_cells
	#   -> [prologue]
	#       -> body
	#	-> loop
	#		-> cond
	#		-> body
	#		-> step
	#	-> b_adjacent
	#   -> [epilogue]

find_adjacent_cells__prologue:
	begin
	push	 $ra
	push	 $s0
	push	 $s1
	push	 $s2
	push	 $s3
	push	 $s4
find_adjacent_cells__body:
	move 	$s0, $a0				# $s0 = &solver
	move 	$s1, $a1				# $s1 = row
	move 	$s2, $a2				# $s2 = col

	lb 	$t0, SIMULATED_BOARD_OFFSET($s0)	# $t0 = fill_region_colour = solver->simulated_board[0][0]

	mul 	$t1, $s1, MAX_BOARD_WIDTH		# $t1 = row * N_COLS
	add 	$t1, $t1, $s2				# $t1 = row * N_COLS + col = offset
	add 	$t2, $s0, ADJACENT_TO_CELL_OFFSET	# $t2 = &solver->adjacent_to_cell
	add 	$t2, $t2, $t1				# $t2 = &solver->adjacent_to_cell[row][col]
	lb 	$t3, ($t2)				# $t3 = solver->adjacent_to_cell[row][col]

	bne 	$t3, NOT_VISITED, find_adjacent_cells__epilogue

	add 	$t4, $s0, SIMULATED_BOARD_OFFSET	# $t4 = &solver->simulated_board[0][0]
	add 	$t4, $t4, $t1				# $t4 = &solver->simulated_board[row][col]
	lb 	$t4, ($t4)				# $t4 = solver->simulated_board[row][col]

	bne 	$t4, $t0, find_adjacent_cells__b_adjacent

	li 	$t5, VISITED				# $t5 = VISITED
	sb 	$t5, ($t2)				# solver->adjacent_to_cell[row][col] = VISITED	
	
	li 	$t6, 0 					# $t6 = int i = 0
find_adjacent_cells__loop_cond:
	bge 	$t6, NUM_VISIT_DELTAS, find_adjacent_cells__epilogue
find_adjacent_cells__loop_body:
	mul 	$t7, $t6, 2				#
	add 	$t7, VISIT_DELTA_ROW			# $t7 = row_delta offset
	mul 	$t7, SIZEOF_INT				# $t8 = (row * N_COLS + col) * SIZEOF_INT = col_delta offset

	mul 	$t8, $t6, 2				#
	add 	$t8, VISIT_DELTA_COL			#
	mul 	$t8, SIZEOF_INT				# $t8 = (row * N_COLS + col) * SIZEOF_INT = col_delta offset

	la 	$s3, visit_deltas			# $s3 = int row_delta
	la 	$s4, visit_deltas			# $s4 = int col_delta

	add 	$s3, $s3, $t7				# $s3 = row_delta = visit_deltas[i][VISIT_DELTA_ROW]
	lw 	$s3, ($s3)
	add 	$s4, $s4, $t8				# $s4 = col_delta = visit_deltas[i][VISIT_DELTA_COL]
	lw 	$s4, ($s4)

	add 	$t0, $s1, $s3				# $t0 = row + row_delta
	lw 	$t1, board_height
	addi 	$t1, -1					# $t1 = board_height - 1
	move 	$a0, $t0
	li 	$a1, 0
	move 	$a2, $t1

	jal	 in_bounds

	beq 	$v0, FALSE, find_adjacent_cells__loop_step

	add 	$t0, $s2, $s4				# $t0 = col + col_delta
	lw 	$t1, board_width
	addi 	$t1, -1					# $t1 = board_width - 1
	move 	$a0, $t0
	li 	$a1, 0
	move 	$a2, $t1

	jal 	in_bounds

	beq 	$v0, FALSE, find_adjacent_cells__loop_step

	add 	$t0, $s1, $s3				# $t0 = row + row_delta
	add 	$t1, $s2, $s4				# $t1 = col + col_delta
	move 	$a0, $s0
	move 	$a1, $t0
	move 	$a2, $t1
	jal 	find_adjacent_cells
find_adjacent_cells__loop_step:
	addi 	$t6, 1					# i++
	b 	find_adjacent_cells__loop_cond

find_adjacent_cells__b_adjacent:
	li 	$t0, ADJACENT				# $t0 = ADJACENT
	sb 	$t0, ($t2)				# solver->adjacent_to_cell[row][col] = ADJACENT
find_adjacent_cells__epilogue:
	pop	$s4
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop 	$ra
	end

	jr	$ra

##########################################################################
## void fill(struct fill_in_progress *fill_in_progress,                 ##
##    char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT], int row, int col); ##
##########################################################################

################################################################################
# .TEXT <fill>
	.text
fill:
	# Subset:   3
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7]   <-- FILL THESE OUT!
	# Uses:     [$v0, $a0, $a1, $a2, $a3, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7]
	# Clobbers: [$v0, $a0, $a1, $a2, $a3, $t0, $t1, $t2, $t3, $t4, $t5, $t6]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t0: row * N_COLS + col = row_col offset, int i = 0
	#   - $t1: &fill_in_progress->visited[row][col], (row * N_COLS + col) * SIZEOF_INT = row_delta offset, row + row_delta, col + col_delta
	#   - $t2: fill_in_progress->visited[row][col], (row * N_COLS + col) * SIZEOF_INT = col_delta offset, board_height - 1, board_width - 1
	#   - $t3: VISITED, board[row][col]
	#   - $t4: fill_in_progress->fill_onto
	#   - $t5: fill_in_progress->fill_with
	#   - $t6: fill_in_progress->cells_filled, &board[row][col]
	#   - $s0: &fill_in_progress
	#   - $s1: &board[0][0]
	#   - $s2: row
	#   - $s3: col
	#   - $s4: int row_delta
	#   - $s5: int col_delta
	#   - $s6: row + row_delta
	#   - $s7: col + col_delta
	#
	# Structure:       
	#   fill
	#   -> [prologue]
	#       -> body
	#	-> skip_cells_filled
	#	-> loop
	#		-> cond
	#		-> body
	#		-> step
	#   -> [epilogue]

fill__prologue:
	begin
	push 	$ra
	push	$s0
	push	$s1
	push 	$s2
	push	$s3
	push	$s4
	push	$s5
	push 	$s6
	push 	$s7
fill__body:
	move 	$s0, $a0				# $s0 = &fill_in_progress
	move 	$s1, $a1				# $s1 = &board[0][0]
	move 	$s2, $a2				# $s2 = row
	move 	$s3, $a3				# $s3 = col

	mul 	$t0, $s2, MAX_BOARD_WIDTH
	add 	$t0, $t0, $s3				# $t0 = row * N_COLS + col = row_col offset

	add 	$t1, $s0, VISITED_OFFSET
	add 	$t1, $t1, $t0				# $t1 = &fill_in_progress->visited[row][col]
	lb 	$t2, ($t1)				# $t2 = fill_in_progress->visited[row][col]

	beq 	$t2, VISITED, fill__epilogue

	li 	$t3, VISITED				# $t3 = VISITED
	sb 	$t3, ($t1)				# fill_in_progress->visited[row][col] = VISITED

	add	$t3, $s1, $t0
	lb 	$t3, ($t3)				# $t3 = board[row][col]
	add 	$t4, $s0, FILL_ONTO_OFFSET		# $t4 = &fill_in_progress->fill_onto
	lb 	$t4, ($t4)				# $t4 = fill_in_progress->fill_onto

	add 	$t5, $s0, FILL_WITH_OFFSET		# $t5 = &fill_in_progress->fill_with
	lb 	$t5, ($t5)				# $t5 = fill_in_progress->fill_with

	bne 	$t3, $t4, fill__epilogue		

	beq 	$t3, $t5, fill__body_skip_cells_filled	#
	lw 	$t6, CELLS_FILLED_OFFSET($s0)		# $t6 = fill_in_progress->cells_filled
	addi 	$t6, 1					#
	sw 	$t6, CELLS_FILLED_OFFSET($s0) 		# fill_in_progress->cells_filled++

fill__body_skip_cells_filled:
	add 	$t6, $s1, $t0				# $t6 = &board[row][col]
	sb	$t5, ($t6)				# board[row][col] = fill_in_progress->fill_with

	li 	$t0, 0					# $t0 = int i = 0
fill__loop_cond:
	bge 	$t0, NUM_VISIT_DELTAS, fill__epilogue
fill__loop_body:
	mul 	$t1, $t0, 2				# $t1 = row * N_COLS
	add 	$t1, VISIT_DELTA_ROW			# $t1 = row * N_COLS + col
	mul 	$t1, SIZEOF_INT				# $t1 = (row * N_COLS + col) * SIZEOF_INT = row_delta offset

	mul 	$t2, $t0, 2				# $t2 = row * N_COLS
	add 	$t2, VISIT_DELTA_COL			# $t2 = row * N_COLS + col
	mul 	$t2, SIZEOF_INT				# $t2 = (row * N_COLS + col) * SIZEOF_INT = col_delta offset

	la 	$s4, visit_deltas			# $s4 = int row_delta
	la 	$s5, visit_deltas			# $s5 = int col_delta

	add 	$s4, $s4, $t1				# $s4 = row_delta = visit_deltas[i][VISIT_DELTA_ROW]
	lw 	$s4, ($s4)	
	add 	$s5, $s5, $t2				# $s5 = col_delta = visit_deltas[i][VISIT_DELTA_COL]
	lw 	$s5, ($s5)

	add 	$t1, $s2, $s4				# $t1 = row + row_delta
	move 	$s6, $t1				# $s6 = row + row_delta
	lw 	$t2, board_height
	addi 	$t2, -1					# $t2 = board_height - 1
	move 	$a0, $t1
	li 	$a1, 0
	move 	$a2, $t2

	jal	 in_bounds

	beq 	$v0, FALSE, fill__loop_step

	add 	$t1, $s3, $s5				# $t1 = col + col_delta
	move 	$s7, $t1				# $s7 = col + col_delta
	lw 	$t2, board_width
	addi 	$t2, -1					# $t2 = board_width - 1
	move 	$a0, $t1
	li 	$a1, 0
	move 	$a2, $t2

	jal 	in_bounds

	beq 	$v0, FALSE, fill__loop_step

	move 	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s6
	move 	$a3, $s7
	
	jal 	fill

fill__loop_step:
	addi 	$t0, 1
	b 	fill__loop_cond
fill__epilogue:
	pop 	$s7
	pop 	$s6
	pop 	$s5
	pop 	$s4
	pop 	$s3
	pop 	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

##################################################
## void solve_next_step(struct solver *solver); ##
##################################################

################################################################################
# .TEXT <solve_next_step>
	.text
solve_next_step:
	# Subset:   3
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7]
	# Uses:     [$v0, $a1, $a2, $t0, $t1, $t2, $t3, $t4, $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7]
	# Clobbers: [$v0, $a1, $a2, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t0: &solver->step_rating_for_colour[i].is_eliminated, &solver->step_rating_for_colour[i].surface_area
	#   - $t1: 2 * SIZEOF_INT, i * 8
	#   - $t2: solver->solution_length
	#   - $t3: &solver->optimal_solution[solver->solution_length]
	#   - $t4: colour_selector[i]
	#   - $s0: &solver
	#   - $s1: int best_surface_area	
	#   - $s2: int best_solution
	#   - $s3: &solver->simulated_board
	#   - $s4: &solver->future_board
	#   - $s5: MAX_BOARD_HEIGHT * MAX_BOARD_WIDTH
	#   - $s6: int i
	#   - $s7: &solver->solution_length
	#
	# Structure:        <-- FILL THIS OUT!
	#   solve_next_step
	#   -> [prologue]
	#       -> body
	#	-> loop
	#		-> cond
	#		-> body
	#		-> body_invalid_step
	#		-> step
	#		-> end
	#	-> loop2
	#		-> cond
	#		-> body
	#		-> step
	#		-> end
	#	-> loop3
	#		-> cond
	#		-> body
	#		-> step
	#		-> end
	#   -> [epilogue]

solve_next_step__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push 	$s2
	push	$s3
	push	$s4
	push	$s5
	push 	$s6
	push 	$s7
solve_next_step__body:
	move 	$s0, $a0				# $s0 = &solver
	li 	$s1, 0					# $s1 = int best_surface_area	
	li 	$s2, 0					# $s2 = int best_solution

	add 	$s3, $s0, SIMULATED_BOARD_OFFSET	# $s3 = &solver->simulated_board
	add 	$s4, $s0, FUTURE_BOARD_OFFSET		# $s4 = &solver->future_board
	li 	$s5, MAX_BOARD_HEIGHT
	mul 	$s5, MAX_BOARD_WIDTH			# $s5 = MAX_BOARD_HEIGHT * MAX_BOARD_WIDTH

	move 	$a0, $s3				# copy_mem
	move 	$a1, $s4				#
	move 	$a2, $s5				#
							#
	jal 	copy_mem				#

	li 	$s6, 0					# $s6 = int i = 0
solve_next_step__loop_cond:
	bge 	$s6, NUM_COLOURS, solve_next_step__loop_end
solve_next_step__loop_body:
	move 	$a0, $s4				# copy_mem(...)
	move 	$a1, $s3				#
	move 	$a2, $s5				#
							#
	jal 	copy_mem				# 

	move 	$a0, $s0				# invalid_step(solver, i)
	move 	$a1, $s6				#
							#
	jal	invalid_step				#

	beq	$v0, TRUE, solve_next_step__loop_body_invalid_step

	move 	$a0, $s0				# simulate_step(solver, i)
	move 	$a1, $s6				#
							#
	jal 	simulate_step				#

	move 	$a0, $s0				# initialise_solver_adjacent_cells(solver)
							#
	jal 	initialise_solver_adjacent_cells	#

	move 	$a0, $s0				# find_adjacent_cells(solver, 0, 0)
	li 	$a1, 0					#
	li	$a2, 0					#
							#
	jal 	find_adjacent_cells			#

	move 	$a0, $s0				# rate_choice(solver, i)
	move 	$a1, $s6				#
							#
	jal 	rate_choice				#

	b 	solve_next_step__loop_step
solve_next_step__loop_body_invalid_step:
	add 	$t0, $s0, STEP_RATING_FOR_COLOUR_OFFSET	# $t0 = &solver->step_rating_for_colour
	li 	$t1, 0
	add 	$t1, SIZEOF_INT
	add 	$t1, SIZEOF_INT				# $t1 = 2 * SIZEOF_INT
	mul 	$t1, $s6, $t1				# $t1 = i * 8
	add 	$t0, $t1				# $t0 = &solver->step_rating_for_colour[i]
	add 	$t0, IS_ELIMINATED_OFFSET		# $t0 = &solver->step_rating_for_colour[i].is_eliminated

	li 	$t1, FALSE				# $t1 = FALSE
	sw 	$t1, ($t0)				# solver->step_rating_for_colour[i].is_eliminated = FALSE

	add 	$t0, $s0, STEP_RATING_FOR_COLOUR_OFFSET # $t0 = &solver->step_rating_for_colour
	add 	$t1, SIZEOF_INT
	add 	$t1, SIZEOF_INT				# $t1 = 2 * SIZEOF_INT
	mul 	$t1, $s6, $t1				# $t1 = i * 8
	add 	$t0, $t1				# $t0 = &solver->step_rating_for_colour[i]

	add 	$t0, SURFACE_AREA_OFFSET		# $t0 = &solver->step_rating_for_colour[i].surface_area
	li 	$t1, -1					# $t1 = -1
	sw 	$t1, ($t0)				# solver->step_rating_for_colour.surface_area = -1
solve_next_step__loop_step:
	addi 	$s6, 1
	b 	solve_next_step__loop_cond
solve_next_step__loop_end:
	move 	$a0, $s4				# copy_mem(...)
	move 	$a1, $s3				#
	move 	$a2, $s5				#
							#
	jal 	copy_mem				#

	li 	$s6, 0					# $s6 = int i = 0
solve_next_step__loop2_cond:
	bge 	$s6, NUM_COLOURS, solve_next_step__loop2_end
solve_next_step__loop2_body:
	add 	$t0, $s0, STEP_RATING_FOR_COLOUR_OFFSET # $t0 = &solver->step_rating_for_colour
	li 	$t1, 0
	add 	$t1, SIZEOF_INT
	add 	$t1, SIZEOF_INT				# $t1 = 2 * SIZEOF_INT
	mul	$t1, $s6				# $t1 = i * 8
	add 	$t0, $t1				# $t0 = &solver->step_rating_for_colour[i]
	add	$t0, IS_ELIMINATED_OFFSET		# $t0 = &solver->step_rating_for_colour[i].is_eliminated
	lw 	$t1, ($t0)				# $t1 = solver->step_rating_for_colour[i].is_eliminated

	bne 	$t1, TRUE, solve_next_step__loop2_step

	add 	$t2, $s0, SOLUTION_LENGTH_OFFSET	# $t2 = &solver->solution_length
	move 	$s7, $t2				# $s7 = &solver->solution_length
	lw 	$t2, ($t2)				# $t2 = solver->solution_length
	add 	$t3, $s0, OPTIMAL_SOLUTION_OFFSET	# $t3 = &solver->optimal_solution
	add	$t3, $t3, $t2				# $t3 = &solver->optimal_solution[solver->solution_length]
	la 	$t4, colour_selector			# $t4 = &colour_selector
	add 	$t4, $t4, $s6				# $t4 = &colour_selector[i]
	lb 	$t4, ($t4)				# $t4 = colour_selector[i]
	sb 	$t4, ($t3)				# solver->optimal_solution[solver->solution_length] = colour_selector[i]

	addi 	$t2, 1					# solver->solution_length++
	sw 	$t2, ($s7)				#

	move 	$a0, $s0				# simulate_step(solver, i)
	move 	$a1, $s6				#
							#
	jal	 simulate_step				#

	move 	$a0, $s3				# copy_mem(...)
	move 	$a1, $s4				#
	move 	$a2, $s5				#
							#
	jal 	copy_mem				#

	b 	solve_next_step__epilogue

solve_next_step__loop2_step:
	addi 	$s6, 1
	b 	solve_next_step__loop2_cond
solve_next_step__loop2_end:

	li 	$s1, -1					# $s1 = best_surface_area = -1
	li 	$s2, -1					# $s2 = best_solution = -1

	li 	$s6, 0					# $s6 = int i = 0
solve_next_step__loop3_cond:
	bge 	$s6, NUM_COLOURS, solve_next_step__loop3_end
solve_next_step__loop3_body:
	add 	$t0, $s0, STEP_RATING_FOR_COLOUR_OFFSET	# $t0 = &solver->step_rating_for_colour
	li 	$t1, 0
	add 	$t1, SIZEOF_INT
	add 	$t1, SIZEOF_INT				# $t1 = 2 * SIZEOF_INT
	mul 	$t1, $t1, $s6				# $t1 = i * 8
	add 	$t0, $t1				# $t0 = &solver->step_rating_for_colour[i]
	add 	$t0, SURFACE_AREA_OFFSET		# $t0 = &solver->step_rating_for_colour[i].surface_area
	lw 	$t1, ($t0)				# $t1 = solver->step_rating_for_colour[i].surface_area

	ble 	$t1, $s1, solve_next_step__loop3_step
	
	move 	$s2, $s6				# $s2 = best_solution = i
	move 	$s1, $t1				# $s1 = best_surface_area = solver->step_rating_for_colour[i].surface_area
solve_next_step__loop3_step:
	addi 	$s6, 1
	b 	solve_next_step__loop3_cond
solve_next_step__loop3_end:
	add 	$t0, $s0, SOLUTION_LENGTH_OFFSET
	move 	$s7, $t0				# $s7 = &solver->solution_length
	lw 	$t0, ($t0)				# $t0 = solver->solution_length
	add 	$t1, $s0, OPTIMAL_SOLUTION_OFFSET	# $t1 = &solver->optimal_solution
	add 	$t1, $t0				# $t1 = &solver->optimal_solution[solver->solution_length]
	la	$t2, colour_selector			# $t2 = &colour_selector
	add 	$t2, $s2				# $t2 = &colour_selector[best_solution]
	lb 	$t2, ($t2)				# $t2 = colour_selector[best_solution]
	sb 	$t2, ($t1)				# solver->optimal_solution[solver->solution_length] = colour_selector[best_solution]

	addi 	$t0, 1					# solver->solution_length++
	sw 	$t0, ($s7)				#

	move 	$a0, $s0				# simulate_step(solver, best_solution)
	move 	$a1, $s2				#
							#
	jal 	simulate_step				# 

	move 	$a0, $s3				# copy_mem(...)
	move 	$a1, $s4				#
	move 	$a2, $s5				#
							#
	jal 	copy_mem				#

solve_next_step__epilogue:
	pop 	$s7
	pop 	$s6
	pop 	$s5
	pop 	$s4
	pop 	$s3
	pop 	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end

	jr	$ra

#########################################################
## void copy_mem(void *src, void *dst, int num_bytes); ##
#########################################################

################################################################################
# .TEXT <copy_mem>
	.text
copy_mem:
	# Subset:   3
	#
	# Frame:    [$ra]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   copy_mem
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

copy_mem__prologue:
	begin
	push	$ra
copy_mem__body:
	move 	$s0, $a0				# $s0 = src_int_ptr
	move 	$s1, $a1				# $s1 = dst_int_ptr
	move 	$s2, $a2				# $s2 = num_bytes

	li 	$t0, 0					# $t0 = char *src_char_ptr
	li 	$t1, 0					# $t1 = char *dst_char_ptr

	li 	$t2, 0					# $t2 = int i = 0
copy_mem__loop1_cond:
	div 	$t3, $s2, SIZEOF_INT			# $t3 = num_bytes / SIZEOF_INT
	bge 	$t2, $t3, copy_mem__loop1_end
copy_mem__loop1_body:
	lw 	$t3, ($s0)				# $t3 = *src_int_ptr
	sw 	$t3, ($s1)				# *dst_int_ptr = *src_int_ptr

	addi 	$s0, SIZEOF_PTR				# dst_int_ptr++
	addi 	$s1, SIZEOF_PTR				# src_int_ptr++
copy_mem__loop1_step:
	addi 	$t2, 1					# i++
	b 	copy_mem__loop1_cond			
copy_mem__loop1_end:
	move 	$t0, $s0				# src_char_ptr = (char*) src_int_ptr
	move 	$t1, $s1				# dst_char_ptr = (char*) dst_int_ptr

	li 	$t3, 0					# $t3 = int i = 0
copy_mem__loop2_cond:
	rem 	$t4, $s2, SIZEOF_INT			# $t4 = num_bytes % SIZEOF_INT
	bge 	$t3, $t4, copy_mem__epilogue
copy_mem__loop2_body:
	lb 	$t5, ($t0)				# $t5 = *src_char_ptr
	sb 	$t5, ($t1)				# *dst_char_ptr = *src_char_ptr

	addi 	$t0, 1
	addi 	$t1, 1
copy_mem__loop2_step:
	addi 	$t3, 1
	b 	copy_mem__loop2_cond
copy_mem__epilogue:
	pop 	$ra
	end

	jr	$ra

##############
## PROVIDED ##
##############

#######################################################################
## unsigned int random_in_range(unsigned int min, unsigned int max); ##
#######################################################################

################################################################################
# .TEXT <random_in_range>
	.text
random_in_range:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$t0, $t1, $t2, $v0]
	# Clobbers: [$t0, $t1, $t2, $v0]
	#
	# Locals:
	#   - $t0: int a;
	#   - $t1: int m;
	#   - $t2: (a * random_seed) % m
	#   - $v0: min + random_seed % (max - min + 1);
	#
	# Structure:
	#   initialise_solver
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]
random_in_range__prologue:
random_in_range__body:
	li	$t0, 16807		# int a = 16807;
	li	$t1, 2147483647		# int m = 2147483647;
	lw	$t2, random_seed	# ... random_seed
	
	mul	$t2, $t2, $t0		# ... a * random_seed

	remu	$t2, $t2, $t1		# ... (a * random_seed) % m

	sw	$t2, random_seed	# random_seed = (a * random_seed) % m;

	move	$v0, $a1		# ... max
	sub	$v0, $v0, $a0		# ... max - min
	add	$v0, $v0, 1		# ... max - min + 1

	rem	$v0, $t2, $v0		# ... random_seed % (max - min + 1)
	add	$v0, $v0, $a0		# return min + random_seed % (max - min + 1);
random_in_range__epilogue:
	jr	$ra

####################################################
## void initialise_solver(struct solver *solver); ##
####################################################

################################################################################
# .TEXT <initialise_solver>
	.text
initialise_solver:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$a0, $a1, $a2]
	# Clobbers: [$a0, $a1, $a2]
	#
	# Locals:
	#   - $a0: game_board
	#   - $a1: solver->simulated_board
	#   - $a2: MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT
	#
	# Structure:
	#   initialise_solver
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

initialise_solver__prologue:
	push	$ra
initialise_solver__body:
	sw	$zero, SOLUTION_LENGTH_OFFSET($a0)	# solver->solution_length = 0;

	la	$a1, SIMULATED_BOARD_OFFSET($a0)	# copy_mem(game_board, solver->simulated_board, MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT);
	la	$a0, game_board				#
	li	$a2, MAX_BOARD_WIDTH			#
	mul	$a2, $a2, MAX_BOARD_HEIGHT		#
	jal	copy_mem				#

initialise_solver__epilogue:
	pop	$ra
	jr	$ra					# return;

##################################################################
## void simulate_step(struct solver *solver, int colour_index); ##
##################################################################

################################################################################
# .TEXT <simulate_step>
	.text
simulate_step:
	# Subset:   provided
	#
	# Frame:    [$s0]
	# Uses:     [$s0, $a0, $a1, $a2, $a3]
	# Clobbers: [$a0, $a1, $a2, $a3]
	#
	# Locals:
	#   - $s0: save argument struct solver *solver
	#   - $a0: &global_fill_in_progress
	#   - $a1: argument 2
	#   - $a2: 0
	#   - $a3: 0
	#
	# Structure:
	#   simulate_step
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

simulate_step__prologue:
	push	$ra
	push	$s0
simulate_step__body:
	move	$s0, $a0

	lb	$a2, SIMULATED_BOARD_OFFSET($a0)#
	la	$a0, global_fill_in_progress	# initialise_fill_in_progress(&global_fill_in_progress, 
	lb	$a1, colour_selector($a1)	#     colour_selector[colour_index], solver->simulated_board[0][0]);
	jal	initialise_fill_in_progress	#

	la	$a0, global_fill_in_progress	# fill(&global_fill_in_progress, solver->simulated_board, 0, 0);
	la	$a1, SIMULATED_BOARD_OFFSET($s0)#
	li	$a2, 0				#
	li	$a3, 0				#
	jal	fill				#
simulate_step__epilogue:
	pop	$s0
	pop	$ra
	jr	$ra				# return;

###################################################################
## void initialise_solver_adjacent_cells(struct solver *solver); ##
###################################################################

################################################################################
# .TEXT <initialise_solver_adjacent_cells>
	.text
initialise_solver_adjacent_cells:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$t0, $t1, $t2, $t3]
	# Clobbers: []
	#
	# Locals:
	#   - $t0: int row;
	#   - $t1: int col;
	#   - $t2: address calculation & reading globals
	#   - $t3: value storage for sw
	#
	# Structure:
	#   initialise_solver_adjacent_cells
	#   -> [prologue]
	#       -> body
	#       -> row
	#           -> row_init
	#           -> row_cond
	#           -> row_body
	#           -> column
	#               -> column_init
	#               -> column_cond
	#               -> column_body
	#               -> column_step
	#               -> column_end
	#           -> row_step
	#           -> row_end
	#   -> [epilogue]

initialise_solver_adjacent_cells__prologue:
initialise_solver_adjacent_cells__body:
initialise_solver_adjacent_cells__row_init:
	li	$t0, 0				# int row = 0;
initialise_solver_adjacent_cells__row_cond:
	lw	$t2, board_height		# while (row < board_height) {
	bge	$t0, $t2, initialise_solver_adjacent_cells__row_end
						#
initialise_solver_adjacent_cells__row_body:
initialise_solver_adjacent_cells__column_init:
	li	$t1, 0				#     int col = 0;
initialise_solver_adjacent_cells__column_cond:
	lw	$t2, board_width		#     while (col < board_width) {
	bge	$t1, $t2, initialise_solver_adjacent_cells__column_end
						#
initialise_solver_adjacent_cells__column_body:
	mul	$t2, $t0, MAX_BOARD_WIDTH	#         ... &[row]
	add	$t2, $t2, $t1			#         ... &[row][col]
	add	$t2, $t2, $a0			#         ... &solver[row][col]
	li	$t3, NOT_VISITED		#
	sb	$t3, ADJACENT_TO_CELL_OFFSET($t2)
						#         solver->adjacent_to_cell[row][col] = NOT_VISITED;
initialise_solver_adjacent_cells__column_step:
	add	$t1, $t1, 1			#         col++;
	b	initialise_solver_adjacent_cells__column_cond
						#     }
initialise_solver_adjacent_cells__column_end:
initialise_solver_adjacent_cells__row_step:
	add	$t0, $t0, 1			#     row++;
	b	initialise_solver_adjacent_cells__row_cond
						# }
initialise_solver_adjacent_cells__row_end:

initialise_solver_adjacent_cells__epilogue:
	jr	$ra				# return;
######################################################################
## void print_board(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]); ##
######################################################################

################################################################################
# .TEXT <print_board>
	.text
print_board:
	# Subset:   provided
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$s0, $s1, $t0, $a0, $v0]
	# Clobbers: [$t0, $a0, $v0]
	#
	# Locals:
	#   - $s0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $s1: int i;
	#   - $t0: loading globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#       -> body
	#       -> row
	#           -> row_init
	#           -> row_cond
	#           -> row_body
	#           -> row_step
	#           -> row_end
	#   -> [epilogue]

print_board__prologue:
	push	$ra
	push	$s0
	push	$s1
print_board__body:
	move	$s0, $a0
print_board__print_row_init:
	li	$s1, 0				# int i = 0;
print_board__print_row_cond:
	lw	$t0, board_height		# while (i < board_height) {
	bge	$s1, $t0, print_board__print_row_end
						#
print_board__print_row_body:
	move	$a0, $s0			#     print_board_row(board, i);
	move	$a1, $s1			#
	jal	print_board_row			#
print_board__print_row_step:
	add	$s1, $s1, 1			#     i++;
	b	print_board__print_row_cond	# }
print_board__print_row_end:
	jal	print_board_seperator_line	# print_board_seperator_line();
	jal	print_board_bottom		# print_board_bottom();

	lw	$a0, steps			# printf("%d", steps);
	li	$v0, 1				#
	syscall					#

	li	$a0, '/'			# putchar('/');
	li	$v0, 11				#
	syscall					#

	lw	$a0, optimal_steps		# printf("%d", optimal_steps + EXTRA_STEPS);
	add	$a0, $a0, EXTRA_STEPS		#
	li	$v0, 1				#
	syscall					#

	la	$a0, str_print_board_steps	# printf(" steps\n);
	li	$v0, 4				#
	syscall					#
print_board__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra				# return;

################################
## void print_board_bottom(); ##
################################

################################################################################
# .TEXT <print_board_bottom>
	.text
print_board_bottom:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$t0, $t1, $t2, $t3, $a0, $v0]
	# Clobbers: [$t0, $t1, $t2, $t3, $a0, $v0]
	#
	# Locals:
	#   - $t0: int i;
	#   - $t1: int j;
	#   - $t2: int k;
	#   - $t3: arithmetic & loading globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board_bottom
	#   -> [prologue]
	#       -> body
	#       -> down
	#           -> down_init
	#           -> down_cond
	#           -> down_body
	#           -> down_step
	#           -> down_end
	#           -> across
	#               -> across_init
	#               -> across_cond
	#               -> across_body
	#               -> not_selected
	#                   -> not_selected_init
	#                   -> not_selected_cond
	#                   -> not_selected_body
	#                   -> not_selected_step
	#                   -> not_selected_end
	#               -> selected
	#                   -> selected1
	#                       -> selected1_init
	#                       -> selected1_cond
	#                       -> selected1_body
	#                       -> selected1_step
	#                       -> selected1_end
	#                   -> i
	#                       -> i_nonzero
	#                       -> i_end
	#                   -> selected2
	#                       -> selected2_init
	#                       -> selected2_cond
	#                       -> selected2_body
	#                       -> selected2_step
	#                       -> selected2_end
	#               -> across_step
	#               -> across_end
	#   -> [epilogue]

print_board_bottom__prologue:
print_board_bottom__body:
print_board_bottom__down_init:
	li	$t0, 0				# int i = 0;
print_board_bottom__down_cond:
	bge	$t0, SELECTED_ARROW_VERTICAL_LENGTH + 1, print_board_bottom__down_end
						# while (i < SELECTED_ARROW_VERTICAL_LENGTH + 1) {
print_board_bottom__down_body:
	li	$v0, 11				#     putchar(BOARD_SPACE_SEPERATOR);
	li	$a0, BOARD_SPACE_SEPERATOR	#
	syscall					#
print_board_bottom__across_init:
	li	$t1, 0				#     int j = 0;
print_board_bottom__across_cond:
	lw	$t3, board_width		#     while (j < board_width) {
	bge	$t1, $t3, print_board_bottom__across_end
						#
print_board_bottom__across_body:

	lw	$t3, selected_column		#         if (j != selected_column) {
	beq	$t1, $t3, print_board_bottom__across_selected
						#

print_board_bottom__not_selected_init:
	li	$t2, 0				#             int k = 0;
print_board_bottom__not_selected_cond:
	bge	$t2, BOARD_CELL_SIZE + 3, print_board_bottom__not_selected_end
						#             while (k < BOARD_CELL_SIZE + 3) {
print_board_bottom__not_selected_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#
print_board_bottom__not_selected_step:
	add	$t2, $t2, 1			#                 k++;
	b	print_board_bottom__not_selected_cond
						#             }
print_board_bottom__not_selected_end:
	b	print_board_bottom__across_step	#         } else {
print_board_bottom__across_selected:
print_board_bottom__across_selected1_init:
	li	$t2, 0				#             int k = 0;
print_board_bottom__across_selected1_cond:
	li	$t3, BOARD_CELL_SIZE + 1	#             while (k < (BOARD_CELL_SIZE + 1) / 2) {
	div	$t3, $t3, 2			#
	bge	$t2, $t3, print_board_bottom__across_selected1_end
						#
print_board_bottom__across_selected1_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#
print_board_bottom__across_selected1_step:
	add	$t2, $t2, 1			#                 k++;
	b	print_board_bottom__across_selected1_cond
						#             }
print_board_bottom__across_selected1_end:

	bnez	$t0, print_board_bottom__across_i_nonzero
						#             if (i == 0) {

	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	b	print_board_bottom__across_i_end
						#             } else {
print_board_bottom__across_i_nonzero:

	sub	$a0, $t0, 1			#                 putchar(selected_arrow_vertical[i - 1]);
	lb	$a0, selected_arrow_vertical($a0)
						#
	li	$v0, 11				#
	syscall					#

print_board_bottom__across_i_end:		#             }

print_board_bottom__across_selected2_init:
	li	$t2, 0				#             k = 0;
print_board_bottom__across_selected2_cond:
	li	$t3, BOARD_CELL_SIZE + 1	#             while (k < ((BOARD_CELL_SIZE + 1) / 2)) {
	div	$t3, $t3, 2			#
	bge	$t2, $t3, print_board_bottom__across_selected2_end
						#
print_board_bottom__across_selected2_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_bottom__across_selected2_step:
	add	$t2, $t2, 1			#                 k++;
	b	print_board_bottom__across_selected2_cond
						#             }
print_board_bottom__across_selected2_end:

print_board_bottom__across_step:
	add	$t1, $t1, 1			#         j++;
	b	print_board_bottom__across_cond	#     }
print_board_bottom__across_end:

	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	li	$a0, '\n'			#     putchar('\n');
	syscall					#

print_board_bottom__down_step:
	add	$t0, $t0, 1			#     i++;
	b	print_board_bottom__down_cond	# }
print_board_bottom__down_end:
print_board_bottom__epilogue:
	jr	$ra				# return;

#########################################################################
## void print_board_row(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT], ##
##     int row);                                                       ##
#########################################################################

################################################################################
# .TEXT <print_board_row>
	.text
print_board_row:
	# Subset:   provided
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$s0, $s1, $s2, $t0, $t1, $a0, $a1, $a2]
	# Clobbers: [$t0, $t1, $a0, $a1, $a2]
	#
	# Locals:
	#   - $s0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $s1: int row
	#   - $s2: int i
	#   - $t0: i == BOARD_CELL_SIZE / 2
	#   - $t1: row == selected_row
	#   - $a0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $a1: int row
	#   - $a2: i == BOARD_CELL_SIZE / 2 && row == selected_row
	#
	# Structure:
	#   print_board_row
	#   -> [prologue]
	#       -> body
	#       -> each_row
	#           -> each_row_init
	#           -> each_row_cond
	#           -> each_row_body
	#           -> each_row_step
	#           -> each_row_end
	#   -> [epilogue]

print_board_row__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
print_board_row__body:
	move	$s0, $a0
	move	$s1, $a1

	jal	print_board_seperator_line	# print_board_seperator_line();

print_board_row__each_row_init:
	li	$s2, 0				# int i = 0;
print_board_row__each_row_cond:
	bge	$s2, BOARD_CELL_SIZE, print_board_row__each_row_end
						# while (i < BOARD_CELL_SIZE) {
print_board_row__each_row_body:
	move	$a0, $s0			#
	move	$a1, $s1			#

	li	$t0, BOARD_CELL_SIZE		#
	div	$t0, $t0, 2			#
	seq	$t0, $t0, $s2			# ... i == BOARD_CELL_SIZE / 2

	lw	$t1, selected_row		#
	seq	$t1, $s1, $t1			# ... row == selected_row
	and 	$a2, $t0, $t1			# ... i == BOARD_CELL_SIZE / 2 && row == selected_row

	jal	print_board_inner_line		# print_board_inner_line(board, row, i == BOARD_CELL_SIZE / 2 && row == selected_row);
print_board_row__each_row_step:
	add	$s2, $s2, 1			#     i++;
	b	print_board_row__each_row_cond	# }
print_board_row__each_row_end:

print_board_row__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra				# return;

################################################################################
## void print_board_inner_line(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT], ##
##     int row, int row_is_selected);                                         ##
################################################################################

################################################################################
# .TEXT <print_board_inner_line>
	.text
print_board_inner_line:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$t0, $t1, $t2, $t3, $a0, $v0]
	# Clobbers: [$t0, $t1, $t2, $t3, $a0, $v0]
	#
	# Locals:
	#   - $t0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $t1: int i;
	#   - $t2: int j;
	#   - $t3: loading globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board_inner_line
	#   -> [prologue]
	#       -> body
	#       -> cells
	#           -> cells_init
	#           -> cells_cond
	#           -> cells_body
	#           -> inner_cell
	#               -> inner_cell_init
	#               -> inner_cell_cond
	#               -> inner_cell_body
	#               -> inner_cell_step
	#               -> inner_cell_end
	#           -> cells_step
	#           -> cells_end
	#   -> [epilogue]

print_board_inner_line__prologue:
print_board_inner_line__body:
	move	$t0, $a0

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_inner_line__cells_init:
	li	$t1, 0				# int i = 0;
print_board_inner_line__cells_cond:
	lw	$t3, board_width		# while (i < board_width) {
	bge	$t1, $t3, print_board_inner_line__cells_end
						#
print_board_inner_line__cells_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_inner_line__inner_cell_init:
	li	$t2, 0				#     int j = 0;
print_board_inner_line__inner_cell_cond:
	bge	$t2, BOARD_CELL_SIZE, print_board_inner_line__inner_cell_end
						#     while (j < BOARD_CELL_SIZE) {
print_board_inner_line__inner_cell_body:
	mul	$a0, $a1, MAX_BOARD_WIDTH	#         ... &[row]
	add	$a0, $a0, $t0			#         ... &board[row]
	add	$a0, $a0, $t1			#         ... &board[row][col]
	lb	$a0, ($a0)			#         putchar(board[row][i]);
	li	$v0, 11				#
	syscall
print_board_inner_line__inner_cell_step:
	add	$t2, $t2, 1			#         j++;
	b	print_board_inner_line__inner_cell_cond
						#     }
print_board_inner_line__inner_cell_end:

	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	lw	$t3, board_width		#     if (i != board_width - 1) {
	sub	$t3, $t3, 1			#
	beq	$t1, $t3, print_board_inner_line__cells_step
						#

	li	$a0, BOARD_CELL_SEPERATOR	#         putchar(BOARD_CELL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_inner_line__cells_step:		#     }
	add	$t1, $t1, 1			#     i++;
	b	print_board_inner_line__cells_cond
						# }
print_board_inner_line__cells_end:

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	beqz	$a2, print_board_inner_line__last_newline
						# if (row_is_selected) {

	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	la	$a0, selected_arrow_horizontal	#     printf("%s", selected_arrow_horizontal);
	li	$v0, 4				#
	syscall					#

print_board_inner_line__last_newline:		# }
	li	$a0, '\n'			#
	li	$v0, 11				#
	syscall					#
print_board_inner_line__epilogue:
	jr	$ra				# return;

########################################
## void print_board_seperator_line(); ##
########################################

################################################################################
# .TEXT <print_board_seperator_line>
	.text
print_board_seperator_line:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$t0, $t1, $t2, $a0, $v0]
	# Clobbers: [$t0, $t1, $t2, $a0, $v0]
	#
	# Locals:
	#   - $t0: int i;
	#   - $t1: int j;
	#   - $t2: globals
	#   - $a0: syscall argument 
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board_seperator_line
	#   -> [prologue]
	#       -> body
	#       -> line
	#           -> line_init
	#           -> line_cond
	#           -> line_body
	#           -> line_step
	#           -> line_end
	#           -> inner_line
	#               -> inner_line_init
	#               -> inner_line_cond
	#               -> inner_line_body
	#               -> inner_line_step
	#               -> inner_line_end
	#   -> [epilogue]

print_board_seperator_line__prologue:
print_board_seperator_line__body:
	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_seperator_line__line_init:
	li	$t0, 0				# int i = 0;
print_board_seperator_line__line_cond:
	lw	$t2, board_width		#
	bge	$t0, $t2, print_board_seperator_line__line_end
						# while (i < board_width) {
print_board_seperator_line__line_body:

print_board_seperator_line__inner_line_init:
	li	$t1, 0				#     int j = 0;
print_board_seperator_line__inner_line_cond:
	bge	$t1, BOARD_CELL_SIZE + 2, print_board_seperator_line__inner_line_end
						#     while (j < BOARD_CELL_SIZE + 2) {
print_board_seperator_line__inner_line_body:
	li	$a0, BOARD_HORIZONTAL_SEPERATOR	#         putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#
print_board_seperator_line__inner_line_step:
	add	$t1, $t1, 1			#         j++;
	b	print_board_seperator_line__inner_line_cond
						#     }
print_board_seperator_line__inner_line_end:
	lw	$t2, board_width		#     if (i != board_width - 1) {
	sub	$t2, $t2, 1			#
	beq	$t2, $t0, print_board_seperator_line__line_step
						#

	li	$a0, BOARD_CROSS_SEPERATOR	#         putchar(BOARD_CROSS_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_seperator_line__line_step:		#     }
	add	$t0, $t0, 1			#     i++;
	b	print_board_seperator_line__line_cond
						# }
print_board_seperator_line__line_end:

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	li	$a0, '\n'			# putchar('\n');
	syscall					#

print_board_seperator_line__epilogue:
	jr	$ra				# return;

#############################
## void process_command(); ##
#############################

################################################################################
# .TEXT <process_command>
	.text
process_command:
	# Subset:   provided
	#
	# Frame:    [$ra]
	# Uses:     [$t0, $t1, $a0, $v0]
	# Clobbers: [$t0, $t1, $a0, $v0]
	#
	# Locals:
	#   - $t0: char command;
	#   - $t1: globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   process_command
	#   -> [prologue]
	#       -> body
	#       -> good_parsing
	#           -> good_parsing_cond
	#           -> good_parsing_end
	#       -> up
	#           -> up
	#           -> up_in_bounds
	#       -> down
	#           -> down
	#           -> down_in_bounds
	#       -> right
	#           -> right
	#           -> right_in_bounds
	#       -> left
	#           -> left
	#           -> left_in_bounds
	#       -> quit
	#       -> fill
	#       -> help
	#       -> cheat
	#       -> unknown
	#       -> end_switch
	#   -> [epilogue]

process_command__prologue:
	push	$ra
process_command__body:
	la	$a0, cmd_waiting
	li	$v0, 4
	syscall

	li	$v0, 12
	syscall
	move	$t0, $v0
process_command__good_parsing_cond:
	bne	$t0, '\n', process_command__good_parsing_end
	li	$v0, 12
	syscall
	move	$t0, $v0
	b	process_command__good_parsing_cond
process_command__good_parsing_end:
	beq	$t0, 'w', process_command__up		# switch (command) {
	beq	$t0, 's', process_command__down		#
	beq	$t0, 'd', process_command__right	#
	beq	$t0, 'a', process_command__left		#
	beq	$t0, 'q', process_command__quit		#
	beq	$t0, 'e', process_command__fill		#
	beq	$t0, 'h', process_command__help		#
	beq	$t0, 'c', process_command__cheat	#
	b	process_command__unknown		#
process_command__up:					#     case 'w':
	lw	$t0, selected_row			#         selected_row = MAX(selected_row - 1, 0);
	sub	$t0, $t0, 1				#
	bge	$t0, 0, process_command__up_in_bounds	#
	li	$t0, 0					#
process_command__up_in_bounds:
	sw	$t0, selected_row			#
	b	process_command__end_switch		#         break;
process_command__down:					#     case 's':
	lw	$t0, selected_row			#         selected_row = MIN(selected_row + 1, board_height - 1);
	add	$t0, $t0, 1				#
	lw	$t1, board_height			#
	sub	$t1, $t1, 1				#
	ble	$t0, $t1, process_command__down_in_bounds
							#
	move	$t0, $t1				#
process_command__down_in_bounds:			#
	sw	$t0, selected_row			#
	b	process_command__end_switch		#         break;
process_command__right:					#     case 'd':
	lw	$t0, selected_column			#         selected_column = MIN(selected_column + 1, board_width - 1)
	add	$t0, $t0, 1				#
	lw	$t1, board_width			#
	sub	$t1, $t1, 1				#
	ble	$t0, $t1, process_command__right_in_bounds
							#
	move	$t0, $t1				#
process_command__right_in_bounds:			#
	sw	$t0, selected_column			#
	b	process_command__end_switch		#         break;
process_command__left:					#     case 'a':
	lw	$t0, selected_column			#         selected_column = MAX(selected_column - 1, 0);
	sub	$t0, $t0, 1				#
	bge	$t0, 0, process_command__left_in_bounds	#
	li	$t0, 0					#
process_command__left_in_bounds:			#
	sw	$t0, selected_column			#
	b	process_command__end_switch		#         break;
process_command__quit:					#     case 'q':
	li	$v0, 10					#         exit(0);
	syscall						#
process_command__fill:					#     case 'e':
	jal	do_fill					#         do_fill();
	b	process_command__end_switch		#         break;
process_command__help:					#     case 'h':
	jal	print_welcome				#         print_welcome();
	b	process_command__epilogue		#         return;
process_command__cheat:					#     case 'c':
	jal	print_optimal_solution			#         print_optimal_solution();
	b	process_command__epilogue		#         return;
process_command__unknown:				#     default:
	la	$a0, str_process_command_unknown	#         printf("Unknown command: ");
	li	$v0, 4					#
	syscall						#

	move	$a0, $t0				#         putchar(command);
	li	$v0, 11					#
	syscall						#

	li	$a0, '\n'				#         putchar('\n')
	syscall						#
	b	process_command__epilogue		#         return;
process_command__end_switch:				# }

	la	$a0, game_board
	jal	print_board				# print_board(game_board);

process_command__epilogue:
	pop	$ra
	jr	$ra					# return;