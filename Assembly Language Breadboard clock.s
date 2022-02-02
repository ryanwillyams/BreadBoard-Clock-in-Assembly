//add -ffunction-sections -lwiringPi -march=armv7ve when compiling
.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1
prompt: .asciz "The time is %d:%d:%d\n"
.align 4
.global main
main:
bl wiringPiSetup
button: mov r0, #0
bl digitalRead
cmp r0, #HIGH
bne button
mov r0, #1
mov r1, #OUTPUT
bl pinMode
mov r0, #14
mov r1, #OUTPUT
bl pinMode
mov r0, #23
mov r1, #OUTPUT
bl pinMode
mov r0, #24
mov r1, #OUTPUT
bl pinMode
mov r0, #25
mov r1, #OUTPUT
bl pinMode
mov r0, #3
mov r1, #OUTPUT
bl pinMode
mov r0, #24
mov r1, #OUTPUT
bl pinMode
mov r0, #25
mov r1, #OUTPUT
bl pinMode
mov r0, #26
mov r1, #OUTPUT
bl pinMode
mov r0, #4
mov r1, #OUTPUT
bl pinMode
mov r0, #27
mov r1, #OUTPUT
bl pinMode
mov r0, #29
mov r1, #OUTPUT
bl pinMode
mov r0, #3
mov r1, #HIGH
bl digitalWrite
mov r0, #24
mov r1, #HIGH
bl digitalWrite
mov r0, #25
mov r1, #HIGH
bl digitalWrite
mov r0, #26
mov r1, #HIGH
bl digitalWrite
mov r0, #4
mov r1, #HIGH
bl digitalWrite
mov r0, #27
mov r1, #HIGH
bl digitalWrite
mov r0, #29
mov r1, #HIGH
bl digitalWrite
mov r0, #2000
bl delay
mov r0, #3
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
timeCalc: mov r0, #23
mov r1, #LOW
bl digitalWrite
mov r0,#0
bl time
mov r4, r0
bl div
sub r6,#8
cmp r6, #0
bmi negative
bl ticker
//message: ldr r0, =prompt
// mov r1, r6
// mov r2, r7
// mov r3, r4
// bl printf
mov r0, #0
pop {pc}
div: push {lr}
mov r0, #0
mov r1, #0
ldr r1,=#86400
.ltorg
ldr r2, =#3600
mov r3, #60
udiv r0, r4, r1
mul r0, r0, r1
sub r4, r0
udiv r5, r4, r2
mov r6, r5
mul r5, r5, r2
sub r4, r5
udiv r0, r4, r3
mov r7, r0
mul r0, r0, r3
sub r4, r0
pop {pc}
negative: mvn r6, r6
add r6, #1
mov r1, #24
sub r6, r1, r6
b ticker
ticker: mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
mov r0, #24
mov r1, #HIGH
bl digitalWrite
mov r0, #500
bl delay
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #500
bl delay
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
b secondtracker
secondtracker:
add r4, #1
cmp r4, #10
blt ticker
mov r0, #27
mov r1, #HIGH
bl digitalWrite
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
cmp r4, #20
blt ticker
mov r0, #4
mov r1, #HIGH
bl digitalWrite
cmp r4, #30
blt ticker
mov r0, #29
mov r1, #HIGH
bl digitalWrite
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
cmp r4, #40
blt ticker
mov r0, #25
mov r1, #HIGH
bl digitalWrite
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
cmp r4, #50
blt ticker
mov r0, #26
mov r1, #HIGH
bl digitalWrite
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
cmp r4, #60
blt ticker
mov r0, #3
mov r1, #HIGH
bl digitalWrite
mov r0, #20
bl delay
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #0
bl digitalRead
cmp r0, #HIGH
beq hours
mov r0, #3
mov r1, #LOW
bl digitalWrite
mov r4, #0
b ticker
hours: mov r0, #500
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #3
mov r1, #LOW
bl digitalWrite
mov r0, #1
mov r1, #HIGH
bl digitalWrite
//#0
cmp r6, #0
moveq r0, #4000
movne r0, #0
bl delay
cmp r6, #0
beq minutes
//#1
cmp r6, #1
moveq r0, #24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #1
moveq r0, #4000
movne r0, #0
bl delay
cmp r6, #1
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r6, #1
beq minutes
// #2
cmp r6, #2
moveq r0, #27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #2
moveq r0, #4000
movne r0, #0
bl delay
cmp r6, #2
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r6, #2
beq minutes
// #3
cmp r6, #3
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #3
moveq r0, #27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #3
moveq r0, #4000
movne r0, #0
bl delay
cmp r6, #3
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r6, #3
beq minutes
//#4
cmp r6, #4
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #4
moveq r0, #4000
movne r0, #0
bl delay
cmp r6, #4
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r6, #4
beq minutes
//#5
cmp r6, #5
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #5
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #5
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r6, #5
beq minutes
//#6
cmp r6, #6
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #6
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #6
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r6, #6
beq minutes
//#7
cmp r6, #7
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #7
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #7
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #7
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r6, #7
beq minutes
//#8
cmp r6, #8
moveq r0,#21
moveq r1, #HIGH
bl digitalWrite
cmp r6, #8
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #21
mov r1, #LOW
bl digitalWrite
cmp r6, #8
beq minutes
//#9
cmp r6, #9
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #9
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #9
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #9
beq minutes
//#10
cmp r6, #10
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #10
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #10
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #10
beq minutes
//#11
cmp r6, #11
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #11
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #11
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #11
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #11
beq minutes
//#12
cmp r6, #12
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #12
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #12
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #12
cmp r6, #12
beq minutes
//#13
cmp r6, #13
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #13
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #13
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #13
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #13
beq minutes
//#14
cmp r6, #14
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #14
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #14
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #14
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #14
beq minutes
//#15
cmp r6, #15
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #15
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #15
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #15
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #15
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r6, #15
beq minutes
//#16
cmp r6, #16
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #16
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #16
beq minutes
//#17
cmp r6, #17
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #17
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #17
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #17
beq minutes
//#18
cmp r6, #18
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #18
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #18
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #18
beq minutes
//#19
cmp r6, #19
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #19
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #19
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #19
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #19
beq minutes
//#20
cmp r6, #20
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #20
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #20
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #20
beq minutes
//#21
cmp r6, #21
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #21
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #21
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #21
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #21
beq minutes
//#22
cmp r6, #22
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #22
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #22
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #22
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #22
beq minutes
//#23
cmp r6, #23
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r6, #23
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r6, #23
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r6, #23
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #23
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #23
beq minutes
//#24
cmp r6, #24
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r6, #24
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r6, #24
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r6, #24
beq minutes
minutes: mov r0, #1
mov r1, #LOW
bl digitalWrite
mov r0, #500
bl delay
mov r0, #14
mov r1, #HIGH
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #3
mov r1, #LOW
bl digitalWrite
//#0
cmp r7, #0
moveq r0, #4000
movne r0, #0
bl delay
cmp r7, #0
beq seconds
//#1
cmp r7, #1
moveq r0, #24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #1
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r7, #1
beq seconds
// #2
cmp r7, #2
moveq r0, #27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #2
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r7, #2
beq seconds
// #3
cmp r7, #3
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #3
moveq r0, #27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #3
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r7, #3
beq seconds
//#4
cmp r7, #4
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #4
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #4
beq seconds
//#5
cmp r7, #5
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #5
moveq r0,#23
moveq r1, #HIGH
bl digitalWrite
cmp r7, #5
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #23
mov r1, #LOW
bl digitalWrite
cmp r7, #5
beq seconds
//#6
cmp r7, #6
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #6
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #6
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #5
beq seconds
//#7
cmp r7, #7
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #7
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #7
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #7
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #7
beq seconds
//#8
cmp r7, #8
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #8
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #21
mov r1, #LOW
bl digitalWrite
cmp r7, #8
beq seconds
//#9
cmp r7, #9
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #9
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #9
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #9
beq seconds
//#10
cmp r7, #10
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #10
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #10
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #10
beq seconds
//#11
cmp r7, #11
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #11
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #11
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #11
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #11
beq seconds
//#12
cmp r7, #12
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #12
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #12
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #12
beq seconds
//#13
cmp r7, #13
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #13
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #13
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #13
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #13
beq seconds
//#14
cmp r7, #14
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #14
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #14
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #14
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #14
beq seconds
//#15
cmp r7, #15
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #15
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #15
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #15
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #15
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #15
beq seconds
//#16
cmp r7, #16
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #16
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #16
beq seconds
//#17
cmp r7, #17
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #17
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #17
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #17
beq seconds
//#18
cmp r7, #18
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #18
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #18
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #18
beq seconds
//#19
cmp r7, #19
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #19
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #19
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #19
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #19
beq seconds
//#20
cmp r7, #20
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #20
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #20
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #20
beq seconds
//#21
cmp r7, #21
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #21
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #21
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #21
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #21
beq seconds
//#22
cmp r7, #22
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #22
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #22
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #22
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #22
beq seconds
//#23
cmp r7, #23
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #23
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #23
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #23
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #23
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #23
beq seconds
//#24
cmp r7, #24
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #24
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #24
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #24
beq seconds
//#25
cmp r7, #25
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #25
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #25
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #25
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #25
beq seconds
//#26
cmp r7, #26
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #26
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #26
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #26
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #26
beq seconds
//#27
cmp r7, #27
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #27
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #27
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #27
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #27
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #27
beq seconds
//#28
cmp r7, #28
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #28
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #28
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #28
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #28
beq seconds
//#29
cmp r7, #29
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #29
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #29
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #29
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #29
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #29
beq seconds
//#30
cmp r7, #30
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #30
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #30
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #30
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #30
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #30
beq seconds
//#31
cmp r7, #31
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #31
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #31
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #31
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #31
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #31
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r7, #31
beq seconds
//#32
cmp r7, #32
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #32
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #32
beq seconds
//#33
cmp r7, #33
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #33
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #33
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #33
beq seconds
//34
cmp r7, #34
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #34
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #34
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #34
beq seconds
//#35
cmp r7, #35
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #35
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #35
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #35
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r7, #35
beq seconds
//#36
cmp r7, #36
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #36
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #36
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #36
beq seconds
//#37
cmp r7, #37
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #37
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #37
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #37
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r7, #37
beq seconds
//#38
cmp r7, #38
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #38
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #38
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #38
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #38
beq seconds
//#39
cmp r7, #39
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #39
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #39
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #39
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #39
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #39
beq seconds
//#40
cmp r7, #40
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #40
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #40
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #40
beq seconds
//#41
cmp r7, #41
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #41
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #41
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #41
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r7, #41
beq seconds
//#42
cmp r7, #42
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #42
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #42
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #42
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #42
beq seconds
//#43
cmp r7, #43
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #43
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #43
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #43
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #43
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #43
beq seconds
//#44
cmp r7, #44
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #44
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #44
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #44
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #44
beq seconds
//#45
cmp r7, #45
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #45
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #45
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #45
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #45
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #45
beq seconds
//#46
cmp r7, #46
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #46
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #46
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #46
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #46
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #46
beq seconds
//#47
cmp r7, #47
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #47
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #47
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #47
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #47
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #47
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #47
beq seconds
//#48
cmp r7, #48
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #48
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #48
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #48
beq seconds
//#49
cmp r7, #49
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #49
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #49
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #49
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r7, #49
beq seconds
//#50
cmp r7, #50
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #50
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #50
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #50
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r7, #50
beq seconds
//#51
cmp r7, #51
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #51
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #51
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #51
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #51
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #51
beq seconds
//#52
cmp r7, #52
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #52
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #52
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #52
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #52
beq seconds
//#53
cmp r7, #53
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #53
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #53
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #53
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #53
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #53
beq seconds
//#54
cmp r7, #54
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #54
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #54
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #54
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #54
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #54
beq seconds
//#55
cmp r7, #55
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #55
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #55
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #55
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #55
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #55
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r7, #55
beq seconds
//#56
cmp r7, #56
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #56
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #56
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #56
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #56
beq seconds
//#57
cmp r7, #57
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #57
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r7, #57
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #57
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #57
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r7, #57
beq seconds
//#58
cmp r7, #58
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #58
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #58
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #58
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #58
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #58
beq seconds
//#59
cmp r7, #59
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r7, #59
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r7, #59
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r7, #59
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r7, #59
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r7, #59
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r7, #59
beq seconds
seconds: mov r0, #14
mov r1, #LOW
bl digitalWrite
mov r0, #500
bl delay
mov r0, #23
mov r1, #HIGH
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #3
mov r1, #LOW
bl digitalWrite
//#0
cmp r4, #0
moveq r0, #4000
movne r0, #0
bl delay
cmp r4, #0
beq timeCalc
//#1
cmp r4, #1
moveq r0, #24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #1
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r4, #1
beq timeCalc
// #2
cmp r4, #2
moveq r0, #27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #2
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r4, #2
beq timeCalc
// #3
cmp r4, #3
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #3
moveq r0, #27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #3
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r4, #3
beq timeCalc
//#4
cmp r4, #4
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #4
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #4
beq timeCalc
//#5
cmp r4, #5
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #5
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #5
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #5
beq timeCalc
//#6
cmp r4, #6
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #6
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #6
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #5
beq timeCalc
//#7
cmp r4, #7
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #7
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #7
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #7
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #7
beq timeCalc
//#8
cmp r4, #8
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #8
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #21
mov r1, #LOW
bl digitalWrite
cmp r4, #8
beq timeCalc
//#9
cmp r4, #9
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #9
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #9
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #9
beq timeCalc
//#10
cmp r4, #10
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #10
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #10
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #10
beq timeCalc
//#11
cmp r4, #11
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #11
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #11
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #11
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #11
beq timeCalc
//#12
cmp r4, #12
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #12
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #12
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #12
beq timeCalc
//#13
cmp r4, #13
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #13
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #13
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #13
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #13
beq timeCalc
//#14
cmp r4, #14
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #14
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #14
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #14
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #14
beq timeCalc
//#15
cmp r4, #15
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #15
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #15
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #15
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #15
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #15
beq timeCalc
//#16
cmp r4, #16
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #16
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #16
beq timeCalc
//#17
cmp r4, #17
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #17
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #17
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #17
beq timeCalc
//#18
cmp r4, #18
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #18
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #18
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #18
beq timeCalc
//#19
cmp r4, #19
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #19
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #19
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #19
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #19
beq timeCalc
//#20
cmp r4, #20
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #20
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #20
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #20
beq timeCalc
//#21
cmp r4, #21
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #21
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #21
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #21
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #21
beq timeCalc
//#22
cmp r4, #22
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #22
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #22
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #22
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #22
beq timeCalc
//#23
cmp r4, #23
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #23
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #23
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #23
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #23
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #23
beq timeCalc
//#24
cmp r4, #24
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #24
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #24
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #24
beq timeCalc
//#25
cmp r4, #25
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #25
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #25
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #25
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #25
beq timeCalc
//#26
cmp r4, #26
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #26
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #26
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #26
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #26
beq timeCalc
//#27
cmp r4, #27
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #27
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #27
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #27
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #27
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #27
beq timeCalc
//#28
cmp r4, #28
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #28
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #28
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #28
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #28
beq timeCalc
//#29
cmp r4, #29
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #29
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #29
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #29
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #29
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #29
beq timeCalc
//#30
cmp r4, #30
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #30
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #30
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #30
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #30
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #30
beq timeCalc
//#31
cmp r4, #31
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #31
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #31
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #31
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #31
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #31
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
cmp r4, #31
beq timeCalc
//#32
cmp r4, #32
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #32
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #32
beq timeCalc
//#33
cmp r4, #33
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #33
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #33
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #33
beq timeCalc
//34
cmp r4, #34
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #34
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #34
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #34
beq timeCalc
//#35
cmp r4, #35
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #35
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #35
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #35
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r4, #35
beq timeCalc
//#36
cmp r4, #36
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #36
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #36
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #36
beq timeCalc
//#37
cmp r4, #37
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #37
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #37
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #37
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r4, #37
beq timeCalc
//#38
cmp r4, #38
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #38
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #38
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #38
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #38
beq timeCalc
//#39
cmp r4, #39
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #39
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #39
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #39
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #39
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #39
beq timeCalc
//#40
cmp r4, #40
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #40
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #40
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #40
beq timeCalc
//#41
cmp r4, #41
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #41
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #41
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #41
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r4, #41
beq timeCalc
//#42
cmp r4, #42
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #42
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #42
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #42
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #42
beq timeCalc
//#43
cmp r4, #43
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #43
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #43
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #43
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #43
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #43
beq timeCalc
//#44
cmp r4, #44
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #44
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #44
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #44
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #44
beq timeCalc
//#45
cmp r4, #45
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #45
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #45
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #45
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #45
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #45
beq timeCalc
//#46
cmp r4, #46
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #46
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #46
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #46
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #46
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #46
beq timeCalc
//#47
cmp r4, #47
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #47
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #47
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #47
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #47
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #47
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #47
beq timeCalc
//#48
cmp r4, #48
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #48
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #48
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #48
beq timeCalc
//#49
cmp r4, #49
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #49
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #49
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #49
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #24
mov r1, #LOW
bl digitalWrite
cmp r4, #49
beq timeCalc
//#50
cmp r4, #50
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #50
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #50
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #50
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
cmp r4, #50
beq timeCalc
//#51
cmp r4, #51
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #51
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #51
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #51
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #51
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #51
beq timeCalc
//#52
cmp r4, #52
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #52
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #52
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #52
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #52
beq timeCalc
//#53
cmp r4, #53
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #53
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #53
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #53
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #53
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #53
beq timeCalc
//#54
cmp r4, #54
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #54
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #54
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #54
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #54
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #54
beq timeCalc
//#55
cmp r4, #55
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #55
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #55
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #55
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #55
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #55
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
cmp r4, #55
beq timeCalc
//#56
cmp r4, #56
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #56
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #56
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #56
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #56
beq timeCalc
//#57
cmp r4, #57
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #57
moveq r0,#4
moveq r1, #HIGH
bl digitalWrite
cmp r4, #57
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #57
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #57
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #4
mov r1, #LOW
bl digitalWrite
cmp r4, #57
beq timeCalc
//#58
cmp r4, #58
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #58
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #58
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #58
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #58
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #58
beq timeCalc
//#59
cmp r4, #59
moveq r0,#24
moveq r1, #HIGH
bl digitalWrite
cmp r4, #59
moveq r0,#27
moveq r1, #HIGH
bl digitalWrite
cmp r4, #59
moveq r0,#29
moveq r1, #HIGH
bl digitalWrite
cmp r4, #59
moveq r0,#26
moveq r1, #HIGH
bl digitalWrite
cmp r4, #59
moveq r0,#25
moveq r1, #HIGH
bl digitalWrite
cmp r4, #59
moveq r0, #4000
movne r0, #0
bl delay
mov r0, #24
mov r1, #LOW
bl digitalWrite
mov r0, #27
mov r1, #LOW
bl digitalWrite
mov r0, #25
mov r1, #LOW
bl digitalWrite
mov r0, #26
mov r1, #LOW
bl digitalWrite
mov r0, #29
mov r1, #LOW
bl digitalWrite
cmp r4, #59
beq timeCalc