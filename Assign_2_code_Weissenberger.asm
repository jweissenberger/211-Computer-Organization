.data
	promptz: .asciiz "Enter the value for z: "
	message: .asciiz "The result is: "
	promptj: .asciiz "Enter the a value for j (0-3): "
	x: .word 10
	y: .word 200
	A: .word 4, 9, 15, 20

.text
	# want to translate: result = x + y - z + A[j]
	
	#prompt the user for z
	li $v0, 4
	la $a0, promptz
	syscall
	
	# get the value for z
	li $v0, 5
	syscall
	
	# store z in $t0
	move $t0, $v0
	
	# prompt the user for j
	li $v0, 4
	la $a0, promptj
	syscall
	
	# get the value for j
	li $v0, 5
	syscall
	
	# store j in $t1
	move $t1, $v0
	
	# load x and y into cpu
	lw $t2, x($zero)
	lw $t3, y($zero)
	
	# add x and y
	add $t4, $t2, $t3
	
	# subtract $t4 - z
	sub $t4, $t4, $t0
	
	la $s0, A         # load base address of array
	move $t5, $t1     # index into A
	sll $t5, $t5, 2   # convert index to byte
	add $t5, $s0, $t5 # full address
	lw $s1, 0($t5)    # load the value into s1
	
	# add $t4 and A[j}
	add $t4, $t4, $s1
	
	# display message
	li $v0, 4
	la $a0, message
	syscall
	
	# print outcome
	li $v0, 1
	move $a0, $t4
	syscall