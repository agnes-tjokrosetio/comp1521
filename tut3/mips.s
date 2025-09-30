
# Example Usage 1

# take from "ans" and put into $t0
lb	$t0, data1
lw	$t0, data1

# take from $t0 and put into "ans" 
sb	$t0, data1
sw	$t0, data1

data1:
# some data stuff here



# Example Usage 2

# take from "data2" and put into $t0
lb	$t1, 8($t0)
lw	$t1, 0($t0)

# take from $t0 and put into "data2" 
sb	$t1, 0($t0)
sw	$t1, 0($t0)

data2:
# some data stuff here
