# Jack Weissenberger
# Assignment 4 part a

.data
	N:	.word		8  # length of the array
	arr:	.word		16, 8, 5, 3, 1, 7, 63, 31 # the arrray of numbers
	tmp:	.word		0xFFFFFFFF
	
.text
# step through the array two indicies at a time and swap the two values if arr[i]>arr[i+1]

	lw $t3, N # load in the length of the array
	la $t1, arr  # get array address
	la $t7, arr   # $t7 will hold the next value
	addi $t7, $t7, 4 # get the address of the next value of the array
	li $t2, 0  # set loop counter

loop:
	beq $t2, $t3, loop_end # check for array end
	
	lw  $a0, ($t1) # put value of the array in 
	lw  $a1, ($t7) # put the following value of the arrry in
	jal swapgt # calling the swap function
	
	addi $t2, $t2, 2 # advance loop counter by two cause we are going though by 2
	addi $t1, $t1, 8 # advance first array pointer by two items
	addi $t7, $t7, 8 # advance second array pointer by two items
	j loop
loop_end:

	#**PRINT LOOP**
	la $t1, arr  # reset address
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

# indicates the end of the program
li $v0, 10
syscall

# returns 1 in v0 if the items are swapped and 0 if not
swapgt:
	slt $s1, $a1, $a0 # compare current value and max
	bne $s1, $zero, swap # if the next value is greater than the max, go there
	li $v0, 0 # return 0 because they were not swapped
	jr $ra # go back to when the funtion was called
	
swap:
	lw $t9, ($t1) # store previous in temporary address
	lw $t8, ($t7) # store the next in a temp address
	#  swap them
	sw $t9, 0($t7)
	sw $t8, 0($t1)
	li $v0, 1 # return 1 in $v0 because they were swapped
	jr $ra	# go back to where the function was called
	
	
	
	
	
	
	
