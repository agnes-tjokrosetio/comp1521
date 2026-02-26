# A simple program demonstrating how to represent a implementing an
# && in an if-statement in MIPS.

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

        # message = "small/big\n";
        la      $t1, small_big_str

	# Note: for statements with multiple conditional branches, write each branch one at a time as if it were a single statement, then translate the statement into MIPS (i.e. use negation)

        # if (x > 100 && x < 1000)
        ble     $t0, 100, print_message
        bge     $t0, 1000, print_message

        # message = "medium";
        la      $t1, medium_str

print_message:
        # printf("%s", message);
        move    $a0, $t1
        li      $v0, 4
        syscall

        # return from main
        jr      $ra                             # return 0;


###################################################################
# Data Segment

        .data

prompt_str:
        .asciiz "Enter a number: "

medium_str:
        .asciiz "medium\n"

small_big_str:
        .asciiz "small/big\n"