# Jack Weissenberger
# 211 assignment 5

.data
	max:    .word   0
	product:.word	0
	sum:	.word	0
	sig:	.word	0
	biased:   .word 0
	unbiased: .word 0
	str1:	.asciiz	"Input 3 floating point numbers on different lines: \n"
	str2:	.asciiz	"Biased and Unbiased exponents and significand: \n"
	str3:	.asciiz	"Max of the first two inputs, Sum, and Product: \n"
	crlf:   .asciiz "\n"		# used to print a new line

.text
	.globl   main		# call to main
	

main:	
	li	$v0, 4		# syscall to print a
	la	$a0, str1	# print the prompt
	syscall

	# first number
	li	$v0, 6		# put first fp into f0
	syscall			
	mov.s	$f12, $f0	# $f0 to $f12
	mov.s	$f1, $f0	# $f0 to $f1

	li	$v0, 2		#Print FP from $f12
	syscall		

	li	$v0, 4		#nl
	la	$a0, crlf	
	syscall
	

	# second number
	li	$v0, 6		# ead FP into $f0
	syscall			

	mov.s	$f12, $f0	# $f0 to $f12 for printing
	mov.s	$f2, $f0	# $f0 to $f2

	li	$v0, 2		# fp from $f12
	syscall			

	li	$v0, 4		# newline
	la	$a0, crlf
	syscall
	
	#Get the third number 
	li	$v0, 6		# read FP into $f0
	syscall			# read
	mov.s	$f12, $f0	# copy $f0 to $f12 for printing
	mov.s	$f3, $f0	# copy $f0 to $f3 for calculating

	li	$v0, 2		# print fp
	syscall			

	li	$v0, 4		# newline
	la	$a0, crlf	
	syscall
	
	
	# string for unbiased and biased exponents and significand
	li	$v0, 4	
	la	$a0, str2	
	syscall
	
	# print biased exponent
	mfc1 	$t0, $f1	# move float into $t0
	sll 	$t0, $t0, 1
	srl 	$t0,$t0, 24
	li 	$v0, 4
	la 	$a0, biased
	syscall
	li 	$v0, 1
	add 	$a0, $t0, $zero
	syscall
	
	li	$v0, 4		#Print a string
	la	$a0, crlf	#Print cr and lf
	syscall
	
	# print unbiased exponent
	addi 	$t0, $t0, -127
	li 	$v0, 4
	la 	$a0, unbiased
	syscall
	li 	$v0, 1
	add 	$a0, $t0, $zero
	syscall
	
	li	$v0, 4		# print string
	la	$a0, crlf	#Print cr and lf
	syscall
	
	# significand
	mfc1 	$t1, $f1	# move float from coprocessor 1 to register $t1
	sll 	$t1, $t1, 9
	srl	$t1, $t1, 9
	addi	$t1, $t1, 8388608
	li 	$v0, 4
	la 	$a0, sig
	syscall
	li	$v0, 1
	add	$a0, $t1, $zero
	syscall
	
	li	$v0, 4
	la	$a0, crlf	# newline
	syscall
	
        li	$v0, 4
	la	$a0, str3	# print string
	syscall
	
	#max
	c.lt.s    $f2, $f1   	# if $f2 < $f1, code = 1 , else: code = 0 
	bc1t      0, printMax1  # go to max1 if true
	c.lt.s    $f1, $f2   	# if $f2 < $f1, code = 1 , else: code = 0 
	bc1t      0, printMax2  # go to max2 if true
	

	
next:
    	mov.s $f12, $f6		# max
    	li $v0, 2
    	syscall
	li	$v0, 4		#Print string
	la	$a0, crlf	#Print cr and lf
	syscall
	
        jal	a3fp    	# calculate the sum
	s.s	$f4, sum

	mov.s	$f12, $f4
	li	$v0, 2		# print sum
	syscall

	li	$v0, 4
	la	$a0, crlf	# print the new line
	syscall
	
	jal	m3fp
	s.s	$f5, product	# store the product

	mov.s	$f12, $f5	# print product
	li	$v0, 2	
	syscall
	
        

	li	$v0, 10		# end program
	syscall



# add($f1 + $f2)+$f3 and put the sum in $f4
a3fp:	add.s	$f8, $f1, $f2
	add.s	$f4, $f8, $f3
	jr	$ra		# return

# multiply($f1 * $f2) * $f3 and put the product in $f5
m3fp:	mul.s	$f7, $f1, $f2
	mul.s	$f5, $f7, $f3
	jr	$ra		# return

printMax1:   
	
	add.s   $f6, $f14, $f1
	mfc1   $v0, $f6
	j next	

printMax2:
 	
 	add.s  $f6, $f14, $f2
 	mfc1   $v0, $f6
 	j next

	

	


	

