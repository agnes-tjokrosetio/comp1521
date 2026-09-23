# A simple program demonstrating how to represent a implementing an && in an
# if-statement in MIPS.

# ##############################################################################
# Code Segment

        .text

main:
	# printf("Enter a number: ");
	li	$v0, 4
	la	$a0, prompt
	syscall

	# scanf("%d", &x);
	li	$v0, 5
	syscall
	move	$t0, $v0

	# char *message = "small/big\n";
	la	$a0, message

	# if (x > 100 && x < 1000) {
	ble	$t0, 100, print_message
	bge	$t0, 1000, print_message

	# message = "medium";
	la	$a0, medium

print_message:
	# printf("%s", message);
	li	$v0, 4
	syscall

	jr	$ra

# ##############################################################################
# Data Segment

        .data
prompt:
	.asciiz "Enter a number: "

message:
	.asciiz "small/big\n"

medium:
	.asciiz "medium"