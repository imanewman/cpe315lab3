   .syntax unified

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global intmul
intmul:
		@ save registers overwritten and 
		@ initialize registers being used
		push {r2,r3,r4,lr}		@ push the lr and overwritten r's onto the stack
		mov r2, r0 		@ move input 1 to r2 to use r0 for product
		mov r0, #0 		@ set r0 to 0, r0 = return product
		mov r3, r1 		@ move input 2 to r3 to use r1 for adding
						@ r2 = mplicand, r3 = mplier 
		mov r4, #1  	@ set r4 to 1, r4 = iteration count, will be left shifted until 0 (32 times)

loop:
		ands r1, r3, #1 @ put the first bit of the mplier into r4 and set cpsr
		beq skip 		@ skip the adding if bit is 0

		mov r1, r2		@ move the mplicand into r1 for adding
		bl intadd 		@ add the mplicand to the product
		
skip:
		@ shift to next bit
		lsl r2, r2, #1 	@ left shift the mplicand
		lsr r3, r3, #1  @ right shift the mplier
		lsls r4, r4, #1	@ left shift r4 and set cpsr
		bne loop		@ loop if unfinished

		@ when program is finished
		pop {r2,r3,r4,pc}    	@ return by poping lr into pc and restore r's
