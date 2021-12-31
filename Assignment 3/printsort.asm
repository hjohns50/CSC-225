#Henry Johnson
#Print Sort
#Register Use
#t1: used as current character bering sorted
#t2: checks for when enter is pushed
#t3: character currently being compared against 
#t4: address of where to put character


.text
.globl main
main:
	addi a7, a7, 4 #prepare for ecall for print string
	la a0, enter #loads string to print
	ecall
loop:	li a7, 12 #prepare ecall for read char
	li t1, 0 #sets t1 to 0 
	li t2, 10 #loads ascii value of "enter" into t2
	ecall
	add t1, a0, t1 #puts input into t1
	beq t1, t2, next #moves on when "enter" key is pressed
	la t4, sort #loads adress of the entered word into t4
	lb t3, (t4) #loads byte at t4 into t3
find:   beqz t3, put #if space is empty put
	ble t1, t3 swap
here:	addi t4, t4, 1
	lb t3, (t4)
	b find 
put:	sb t1, (t4) #puts the character into memory
	b loop 	#back to top of loop
swap:   sb t1, (t4)
	li t1, 0
	add t1, t1, t3
	b here
next: 	li a7, 4
	la a0, alp
	ecall
	la a0, sort
	ecall
	b main
	
.data
enter: .string "Enter word: "
sort: .space 20
alp: .string "Alphabetized word: "
