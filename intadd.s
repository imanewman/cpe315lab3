   .syntax unified

   @ Template file for Lab 3
   @ Team member names here: Tim Newman, Josh Conrad

    .arch armv7a
    .fpu vfp

    @ --------------------------------
    .global intadd
intadd:
		@ save registers overwritten and
		@ initialize registers being used
		push {r2,r3,r4,r5,r6,r7} 	@ save any registers overwritten
		mov r2, #0 		@ set r2 to 0, r2 = result
		mov r3, #1		@ set r3 to 1, r3 = a single one to be shifted left
		mov r4, #0 		@ set r4 to 0, r4 = single bit result
		mov r5, #0 		@ set r5 to 0, r5 = single bit carry
		mov r6, #0 		@ set r6 to 0, r6 = single bit of first input
		mov r7, #0 		@ set r7 to 0, r7 = single bit of second input

		@ loop until r3 becomes 0 (all bits checked)
loop:
		@ set the bit of the result
		and r6, r3, r0 	@ set r6 = nth bit of first input
		and r7, r3, r1 	@ set r7 = nth bit of second input
		eor r4, r7, r6 	@ set r4 = eor of the 2 bits and the carry,
		eor r4, r4, r5  @          representing that bit of the result
		orr r2, r2, r4  @ effectively add single bit to result

		@ set the carry bit
		and r4, r6, r7  @ set r4 = and of nth bits
		cmp r4, r3 		@ compare with the current bit
		beq eq 			@ if equal (is a carry) branch to eq
		orr r4, r6, r7  @ set r4 = or of nth bits
		and r4, r4, r5  @ set r4 = and of above with carry
		cmp r4, r3 		@ compare with the current bit
		beq eq 			@ if equal (is a carry) branch to eq
		@ if no carry
		mov r5, #0 		@ set carry bit to 0
		b skip 			@ branch to skip
eq:
		mov r5, r4 		@ move carry bit into r5
		lsleq r5, r5, #1 @ shift the carry bit to correct spot

skip:
		@ shift to checking the next bit
		lsls r3, r3, #1 @ left shift mask and set cpsr
		bne loop 		@ loop if program isnt finished

end:
		@ if the program is finished
		mov r0, r2 		@ set r0 = return value in r2
		pop {r2,r3,r4,r5,r6,r7}		@ restore all registers
		mov pc, lr 		@ return to caller
