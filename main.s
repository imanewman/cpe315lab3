    .syntax unified

    @ Template file for Lab 3
    @ Team member names here: Tim Newman, Josh Conrad

    .arch armv7a
    .fpu vfp 

    @ --------------------------------
    .global main
main:
    @ driver function main lives here, modify this for your other functions
    push {lr}             @ push lr onto stack 
loop:
    sub sp, sp, #16       @ make 4 places on the stack for scans
    ldr r0, printdata     @ load address of print number 1 to r0
    bl printf             @ print string
    ldr r0, =scanint      @ load scan string to r0
    add r1, sp, #12       @ save sp + 12 to r1
    bl scanf              @ scan in an int
    ldr r0, printdata+4   @ load address of print number 2 to r0
    bl printf             @ print string
    ldr r0, =scanint      @ load scan string to r0
    add r1, sp, #8        @ save sp + 8 to r1
    bl scanf              @ scan in an int
    ldr r3, [sp, #8]      @ load second input to r3 
    ldr r0, printdata+8   @ load print operation to r0
    bl printf             @ print string
    ldr r0, =scanchar     @ load scan string to r0
    add r1, sp, #4        @ save sp + 4 to r1
    bl scanf              @ scan in a char
    ldrb r0, [sp, #4]     @ load operation to r0

addcmp:
    ldr r1, =add          @ load address of '+' to r1
    ldrb r1, [r1]         @ load value of '+' to r1
    cmp r0, r1            @ compare input with add
    bne subcmp            @ branch to subcmp if op isnt add
    ldr r0, [sp, #12]     @ load first input to r0 
    ldr r1, [sp, #8]      @ load second input to r1 
    bl intadd             @ branch to intadd
    b printres            @ branch to printres after add 

subcmp:
    ldr r1, =sub          @ load address of '-' to r1
    ldrb r1, [r1]         @ load value of '-' to r1
    cmp r0, r1            @ compare input with sub
    bne mulcmp            @ branch to mulcmp if op isnt sub
    ldr r0, [sp, #12]     @ load first input to r0 
    ldr r1, [sp, #8]      @ load second input to r1 
    bl intsub             @ branch to intsub
    b printres            @ branch to printres after sub

mulcmp:
    ldr r1, =mul          @ load address of '*' to r1
    ldrb r1, [r1]         @ load value of '*' to r1
    cmp r0, r1            @ compare input with mul
    bne inval             @ branch to inval if op isnt mul
    ldr r0, [sp, #12]     @ load first input to r0 
    ldr r1, [sp, #8]      @ load second input to r1 
    bl intmul             @ branch to intmul
    b printres            @ branch to printres after mul

inval:
    ldr r0, printdata+20  @ load print invalid to r0
    bl printf             @ print string
    b end                 @ branch to end

printres:
    mov r1, r0            @ move result to r1
    ldr r0, printdata+12  @ load print result to r0
    bl printf             @ print string

end:
    ldr r0, printdata+16  @ load print again to r0
    bl printf             @ print string
    ldr r0, =scanchar
    mov r1, sp            @ save stack pointer to r1
    bl scanf
    ldr r1, =yes          @ load address of 'y' to r1
    ldrb r1, [r1]         @ load char 'y' to r1
    ldrb r0, [sp]         @ load user input to r0
    cmp r0, r1            @ compare input to 'y'
    add sp, sp, #16       @ remove allocated space from stack before loop
    beq loop              @ loop if input is 'y'
    pop {pc}              @ pop lr into pc at end

yes:
    .byte   'y'
add:
    .byte   '+'
sub:
    .byte   '-'
mul:
    .byte   '*'
scanchar:
    .asciz  " %c"
scanint:
    .asciz  "%d"

printdata:
    .word enter1
    .word enter2
    .word enterOp
    .word result
    .word again
    .word invalid

enter1:
    .asciz "Enter Number 1: "
enter2:
    .asciz "Enter Number 2: "
enterOp:
    .asciz "Enter Operation: "
result:
    .asciz "Result is: %d\n"
again:
    .asciz "Again? "
invalid:
    .asciz "Invalid Operation Entered.\n"


    @ pi server: ssh 129.65.128.71



    @ You'll need to scan characters for the operation and to determine
    @ if the program should repeat.
    @ To scan a character, and compare it to another, do the following
    @  ldr     r0, =scanchar
    @  mov     r1, sp          @ Save stack pointer to r1, you must create space
    @  bl      scanf           @ Scan user's answer
    @  ldr     r1, =yes        @ Put address of 'y' in r1
    @  ldrb    r1, [r1]        @ Load the actual character 'y' into r1
    @  ldrb    r0, [sp]        @ Put the user's value in r0
    @  cmp     r0, r1          @ Compare user's answer to char 'y'
    @  b       loop            @ branch to appropriate location
    @ this only works for character scans. You'll need a different
    @ format specifier for scanf for an integer ("%d"), and you'll
    @ need to use the ldr instruction instead of ldrb to load an int.
