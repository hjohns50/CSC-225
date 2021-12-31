#Henry Johnson and Robert Vermeulen
#Test int
#Register Use


.text
.globl main
main:	la t0, init #loads init into t0
	jalr t0 #jumps to initilizer subroutine
	li a0, 42 #loads astriks into a0
loo:	jal printchar #jumps to print char to print said a0 value
	jal readchar
	b loo
.data
.globl string RCR RDR TCR TDR
string: .space 20
RCR: .word 0xffff0000
RDR: .word 0xffff0004
TCR: .word 0xffff0008
TDR: .word 0xffff000c