# Jack Weissenberger
# assign_3_II_weissenberger

# the sum will be stored in $t0
# the max will be stored in $t4
# in buble the list will update in place and then the whole list will be printed out in the end

.data
	N: .word 7 # this is the length of the list
	sum: .word 0 # the sum of the list
	max: .word 0 # max of the list
	hld1: .word 0xAAAAAAAA
	vals: .word 5, 8, 1, -3, 7, 10, 2
	sum_message: .asciiz "The sum of the array is: "
	loop_message: .asciiz "\nAfter bubble, the array is: "
	max_message: .asciiz "\nThe max of the arrray is: "
	hld2: .word 0xFFFFFFFF
		
.text
	lw $t3, N
	
	# **SUM**
	la $t1, vals  # get array address
	li $t2, 0  # set loop counter
	lw $t0, sum  # set sum to be zero

sum_loop:
	beq $t2, $t3, sum_end # check for array end
	
	lw  $a0, ($t1) # put value of the array in 
	add $t0, $t0, $a0 # add the current value to the sum
	
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	j sum_loop
sum_end:	
	
	# display print message
	li $v0, 4
	la $a0, sum_message
	syscall
	
	# print sum
	li $v0, 1
	move $a0, $t0
	syscall
	
	# **MAX**
	la $t1, vals  # get array address
	li $t2, 0  # set loop counter
	lw $t4, max  # set max to be zero

max_loop:
	beq $t2, $t3, max_end # check for array end
	
	lw  $a0, ($t1) # put value of the array in 
	slt $s1, $a0, $t4 # compare current value and max
	beq $s1, $zero, switch_max # if the new value is greater than the max, go there
	
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	j max_loop
switch_max:
	lw $t4, ($t1) # make the max the currect value of the array
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	j max_loop
max_end:	
	
	# display print message
	li $v0, 4
	la $a0, max_message
	syscall
	
	# print max
	li $v0, 1
	move $a0, $t4
	syscall
	
	#**BUBBLE LOOP** 
	la $t1, vals  # get array address
	la $t7, vals   # $t7 will hold the next value
	addi $t7, $t7, 4 # get the address of the next value of the array
	li $t2, 1  # set loop counter (one higher because were comparing value in front)
	#lw $t7, max  # set max to be zero

bub_loop:
	beq $t2, $t3, bub_end # check for array end
	
	lw  $a0, ($t1) # put value of the array in 
	lw  $a1, ($t7) # put the following value of the arrry in 
	slt $s1, $a1, $a0 # compare current value and max
	bne $s1, $zero, switch_bub # if the next value is greater than the max, go there
	
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance first array pointer
	addi $t7, $t7, 4 # advance second array pointer
	j bub_loop
switch_bub:
	#lw $t4, ($t1) # make the max the currect value of the array
	lw $t9, ($t1) # store previous in temporary address
	lw $t8, ($t7) # store the next in a temp address
	#  swap them
	sw $t9, 0($t7)
	sw $t8, 0($t1)
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	addi $t7, $t7, 4 # advance second array pointer
	j bub_loop
bub_end:
	
	
	#**PRINT LOOP**
	
	# display print message
	li $v0, 4
	la $a0, loop_message
	syscall
	la $t1, vals  # reset address
	li $t2, 0  # set loop counter

print_loop:
	beq $t2, $t3, print_end # check for array end
	
	lw  $a0, ($t1) # print value at array pointer
	li  $v0, 1
	syscall
	
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	j print_loop
print_end: