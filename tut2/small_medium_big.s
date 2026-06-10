# A simple program demonstrating how to represent a implementing an && in an
# if-statement in MIPS.

# ##############################################################################
# Code Segment

        .text

main:
	# printf("Enter a number: ");
	li	$v0, 4
	la	$a0, prompt_str
	syscall

	# scanf("%d", &x);
	li	$v0, 5
	syscall
	move	$t0, $v0

	# char *message = "small/big\n";
	la	$t1, small_big

	# if (x > 100 && x < 1000)
	ble	$t0, 100, print_message
	bge	$t0, 1000, print_message

	# message = "medium";
	la	$t1, medium

print_message:
	# printf("%s", message);
	move	$a0, $t1
	li	$v0, 4
	syscall

	# return
	jr	$ra

# ##############################################################################
# Data Segment

        .data
prompt_str:
	.asciiz "Enter a number: "

small_big:
	.asciiz "small/big\n"

medium:
	.asciiz "medium"