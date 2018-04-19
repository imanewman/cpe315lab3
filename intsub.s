   .syntax unified

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global intsub
intsub:
		push {lr}		@ push the link register onto the stack

		neg r1, r1 		@ multiply second argument by -1
		bl intadd 		@ add together

		@ when program is finished, r0 already holds return value
		pop {pc}    	@ return by poping lr into pc
