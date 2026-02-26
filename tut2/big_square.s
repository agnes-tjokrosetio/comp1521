# Squares a number, unless it is too big for a 32-bit register.
# If it is too big, prints an error message instead.

# Constant
SQUARE_MAX = 46340

 ###################################################################
# Code Segment

        .text

main:

        # printf("Enter a number: ");
        la      $a0, prompt_str
        li      $v0, 4
        syscall

        # scanf("%d", x);
        li      $v0, 5
        syscall
        move    $t0, $v0

	# Note: try to take the negation of conditional statements

        # if (x > SQUARE_MAX)
        ble     $t0, SQUARE_MAX, print_square

        #     printf("square too big for 32 bits\n");
        la      $a0, too_big_str
        li      $v0, 4
        syscall

        b       end

        # else
print_square:
        #     y = x * x
        mul     $t0, $t0, $t0

        #     printf("%d\n", y);
        move    $a0, $t0
        li      $v0, 1
        syscall

        li      $a0, '\n'
        li      $v0, 11
        syscall

end:
        # return from main
        jr      $ra


###################################################################
# Data Segment
        .data

prompt_str:
        .asciiz "Enter a number: "

too_big_str:
        .asciiz "square too big for 32 bits\n"