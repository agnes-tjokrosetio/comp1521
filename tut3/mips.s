
# Example Usage 1

# take from "ans" and put into $t0
lb	$t0, ans
lw	$t0, ans

# take from $t0 and put into "ans" 
sb	$t0, ans
sw	$t0, ans


# Example Usage 2

la	$t0, ans
# take from address in $t0 and put into $t1
lb	$t1, 0($t0)
lw	$t1, 0($t0)

# take from $t1 and put into address in $t0
sb	$t1, 0($t0)
sw	$t1, 0($t0)


ans:
# stuff here