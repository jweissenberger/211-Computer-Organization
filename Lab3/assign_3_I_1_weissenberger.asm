# Jack Weissenberger 2.20
# assign_3_I_1_weissenberger.s

.data
t0val: .word 0x8F0F0F0F
t1val: .word 0X90A0A0A0

.text
.globl main

main: 
	lw $t0, t0val
	lw $t1, t1val
	
	srl $t2, $t0, 10  # shift t0 right by 10
	sll $t2, $t2, 26  # shift above result 26 to left st 0-25 is zero
	sll $t1, $t1, 6   # shift left t1 by 6
	srl $t1, $t1, 6   # shift right t1 by six so last contain zeros
	add $t1, $t2, $t1 # add t1 and t2, t1 will have the result
	
	# display print message
	li $v0, 4
	la $a0, $t1
	syscall
