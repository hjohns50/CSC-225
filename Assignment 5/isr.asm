.text
.globl handler init
init: 
	li t4, 2
	lw t3, RCR
	sw t4, (t3)
	li t3, 0
	add t3, t3, ra
	csrrw zero, uscratch, zero #set ssp to top of memory
	la t0, handler #loads address of handler into t0
	li t1, 256 #loads bit 8 as a 1
	csrrs zero, 4, t1 #allows for device interrupts
	csrrw zero, 5, t0 #writes handler address to utvec
	csrrsi zero, 0, 1 #sets first bit to 1 in ustatus to enable globl interupts
	la a0, initstr #loads init string for printing
	la t2, printstring #prints string
	jalr t2 #jumps to print string subroutine
	jalr t3 #jumps back to main
	
handler:
	csrrw sp, 64, sp   # swap run-time sp and system sp
	addi  sp, sp, -24   # create space on system stack
	sw t0, 12(sp)
	sw t1, 8(sp)
	sw t2, 4(sp)
	sw t3, 16(sp)
	sw t4, 20(sp)
	lw, t3, count
	addi t3, t3, 1
	li t2, 5
	la a0, hstring
	la t0, printstring
	jalr t0
	lw t1, RDR
	lbu a0, (t1)
	beq t3, t2, five
	lw t0, 12(sp)
	lw t1, 8(sp)
	lw t2, 4(sp)
	lw t3, 16(sp)
	lw t4, 20(sp)
	addi  sp, sp, 24   # pop space
	csrrw sp, 64, sp   # swap run-time sp and system sp
	uret
five:   la t4, main
	lw t0, 12(sp)
	lw t1, 8(sp)
	lw t2, 4(sp)
	lw t3, 16(sp)
	lw t4, 20(sp)
	addi  sp, sp, 24   # pop space
	csrrw sp, 64, sp   # swap run-time sp and system sp
	jal main
	
.data
.globl initstr savera
initstr: .string "\nInitializing Interrupts\n"
savera: .word 0
hstring: .string "\nkey pressed is : %c\n"
count: .word 0