# Jack Weissenberger
# Assignment 4 part b

.data
prompt: .asciiz "Enter a positive value to get fib for:"
ans: .asciiz "Fibonacci  of input is: "


.text
	la $a0, prompt  # ask the user for an input
	li $v0, 4
	syscall

	li $v0, 5    # read the number to get fib for 
	syscall

	move $t2, $v0    # copy  n into $t2 
	move $a0, $t2 # copy $t2 into $a0 argument
	move $v0, $t2 # t2 into v0
	jal fib     # call fib 
	move $t3, $v0    # put result into t3

	la $a0, ans   # print result
	li $v0, 4
	syscall

	move $a0, $t3  # print the result
	li $v0, 1
	syscall

	# make sure the program ends
	li $v0, 10
	syscall

fib:
	# these are the cases for 0 and 1
	beqz $a0, zero   
	beq $a0, 1, one 

	# recursive call
	sub $sp, $sp, 4   # put address on the stack
	sw $ra, 0($sp)	  # storing it
	sub $a0, $a0, 1   # decrement N
	jal fib     	  # recursive call with new n
	add $a0, $a0, 1	  # put n back
	lw $ra, 0($sp)   # putting return addresss on the stack
	add $sp, $sp, 4  # storing it
	sub $sp, $sp, 4  # put return value on the stack stack
	sw $v0, 0($sp)   # storing it
	sub $sp, $sp,4   #storing return address on stack for n-2
	sw $ra, 0($sp)   # storing it 
	sub $a0, $a0,2   # decrementing by 2
	jal fib     	 # recursive call for n-2 
	add $a0, $a0,2 	 # putting back n


	lw $ra, 0($sp)  # fixing the return address on the stack
	add $sp, $sp, 4 # incrementing the address by 1 unit
	lw $s7, 0($sp)  #taking the return address from the stack 
	add $sp, $sp, 4 # incrementing address by 1 unit

	add $v0,$v0,$s7 # final addition of the results
	jr $ra          # subracting one from the stack

zero:
	# case that the user enters 0, return 0
	li $v0, 0
	jr $ra
one:
	# case that the user enters 1, return 1
	li $v0, 1
	jr $ra
