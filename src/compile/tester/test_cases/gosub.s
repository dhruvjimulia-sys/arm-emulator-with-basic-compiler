mov r0,#0
add r0,r0,#49
lsl r0,#8
add r0,r0,#32
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#114
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
mov r0,#0
add r0,r0,#32
lsl r0,#8
add r0,r0,#50
lsl r0,#8
add r0,r0,#63
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#12
str r0,[r1]
prints #65288
inputn r0
cmp #1,r0
beq .L0
b .L1
.L0:
mov r13,#0xff04
str r15,[r13],#-4
b one
.L1:
mov r0,#2
printn r0
one:
mov r0,#1
printn r0
ldr r0,[r13]
add r0,#4
b r0
andeq r0,r0,r0
