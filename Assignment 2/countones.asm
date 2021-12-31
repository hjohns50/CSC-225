#Henry Johnson
#Count Ones
#Register Use

#1.) -1412567296
#2.) Register 2 is used to keep track of the address in memory of where the next number is coming from
# in tbl. 
#3.) It is incremented by 4 because the memory address is on a by 4 boundary
#4.) 10 is loaded into Ra because it acts as a counter so the program loops
# the same amount of times as there are items in tbl


.text
.globl main
main:
	addi t1, t1, 0 #sets t1 to 0
	addi a0, a0, 0 #sets r0 to 0
	addi a7, a7, 5 #sets r7 to 5 to prep for ecall
	ecall #get input
	li t2, 0x10010000 #correct location for storage 
	add t1, a0, t1 #puts input into t1
	sw t1, (t2)    #puts input to memory at correct location
	addi t6, t6, 32 #sets t6 to 32 to act as a counter
	addi t3, t3, 1 #sets t3 to act as the mask
	addi t5, t5, 0 #sets t5 to 0 to act as counter of 1s
loop: #label for loop
	addi t6, t6, -1 #subtracts from counter
	and t4, t1, t3 #masks t3 and t1 stores in t4
	beq t4, t3, one #checks to see if it was a 1
	b next #goes to next part, skips the adding to 1 counter
one: #label for if theres a 1
	addi t5, t5, 1	#increments 1 counter
	b next #continues the code
next: #label for next part of program
	add t3, t3, t3 #updates the mask
	beqz t6 end #goes to end after 32 iterations
	b loop #goes back to loop
end: #label for after the loop
	li t2, 0x10010004
	sw t5, (t2)
	
