#Henry Johnson and Robert Vermeulen
#MMIO
#Register Use


.text
.globl readchar printchar printstring

readchar:
	andi t4, t4, 0
	add t4, ra, zero
	lw   t1, RDR # get RDR addr
	lw   t1, RCR # get RCR addr
	lw   t0, (t1)# get RCR value
	andi t0, t0, 1
	beq  t0, zero, done2
	lw   t1, RDR # get RDR addr
	lbu  t0, (t1) # read char
done2:	jalr t4
printchar:
	tpoll:  lw   t1, TCR
		lw   t6, (t1)
		andi t6, t6, 1
		beq  t6, zero, tpoll
		lw   t1, TDR
		sw   a0, (t1) # write char
	#li a7, 11 #printchar ecall value
	#ecall #a0 has the value to print
	ret
printstring:
	li t0, 0 #clear t0
	addi t0, a0, 0 #set t0 to start address of string
	li t5, 0 #clears t1
	addi t5, ra, 0 #saves return address to t1
	loop:
		lb a0, (t0) #load char into a0
		beqz a0, done #check if null
		jal printchar #print the character
		addi t0, t0, 1 #goes to next char
		b loop
	done: jalr t5
	
	
.data
storeA0: .word
storeA7: .word
