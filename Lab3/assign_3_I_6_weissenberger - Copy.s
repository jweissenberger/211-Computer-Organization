# Jack Weissenberger
# 2.27 assign_3_I_6_weissenberger

.data
	a: .word 2 # $s0
	b: .word 2 # $s1
	i: .word 0 # $t0
	j: .word 0 # $t1
	D: .word 2, 3, 4, 5 # base address in $s2

.text
.globl main

main:
	# load in each of the variables
	lw $s0, a
	lw $s1, b
	lw $t0, i
	lw $t1, j
	la $s2, D 
	

Loop1:   
	slt $t2, $t0, $s0      # i < a
   	beq $t2, $0, End       # i >= a, go to end
   	addi $t0, $t0, 1       # i += 1

Loop2:   
	slt $t2, $t1, $s1      # j < b
   	beq $t2, $0, Loop1     # j >= b go to loop1
   	add $t2, $t0, $t1      # i+j
   	sll $t4, $t1, 4        # $t4 = 4*j   
   	add $t3, $t4, $s2      # $t3 = &D[4*j]
   	sw $t2, 0($t3)         # D[4*j] = i+j
   	addi $t1, $t1, 1       # j += 1
   	j Loop2			# loop2 again

End:
	li $v0, 10
	syscall