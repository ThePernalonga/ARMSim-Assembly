@ Just some codes that make a loop, and print
@ Every second passed

.equ PrintS,0x204                       @ Bind to print a String on the LCD
.equ Print,0x205                        @ Bind to print an Integer on the LCD
.equ Clear,0x206                        @ Bind to clear the LCD
.equ Ticks,0x6d                         @ Bind to get time in r0, but in miliseconds

.text

    str_phrase: .asciz "Program running for"
    str_seconds: .asciz "Seconds"

.align

@ Setting up some Integers to use on functions
swi Clear                               @ This will clear the LCD
mov r9, #0                              @ Start the timer with value '0'

mov r0, #0                              @ Setting up the print in LCD, more in
mov r1, #0                              @ HelloWorld.s, also in the repo
ldr r2, =str_phrase                     
swi PrintS
mov r1, #2
ldr r2, =str_seconds
swi PrintS

Start:
    swi Ticks                           @ Get a tick and put in r0
    mov r8, r0
    b Clock                             @ Goes to 'Clock' function

Clock:
    swi Ticks
    sub r0, r0, r8
    cmp r0, #1000                       @ 'cmp' compares the first instruction with the
    beq Timer                           @ second and go to the next instruction
    bne Clock                           @ 'Batch Equal', if the previous cmp is 'true'
                                        @ It calls the function 'Timer'
                                        @ 'Batch not Equal', if the previous cmp is 'false'
                                        @ It calls himself again, causing a loop
                                        @ In this case it will stop only if the simulator stops


Timer:
    add r9, r9, #1                      @ Adds in r9 himself and 1 (r9++ or r9 = r9 + 1)
    mov r0, #0                          @ Putting in r0 the value of #0, will be used to print
    mov r1, #1                          @ Putting in r1 the value of #1, will be used to print
    mov r2, r9                          @ Putting in r2 the value of r9, will be used to print
    swi Print
    b Start                             @ It makes the program go back to the timer, and continue the loop


.end


