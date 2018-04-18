   .syntax unified

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global intsub
intsub:
		@ save registers overwritten and 
		@ initialize registers being used
		push {lr}		@ push the link register onto the stack
		push {r1} 		@ save second argument 

		neg r1, r1 		@ multiply second argument by -1
		bl intadd 		@ add together

		@ when program is finished, r0 already holds return value
		pop {r1} 		@ take r1 off stack
		pop {pc}    	@ return by poping lr into pc
		