mov r14,#32644
mov r0,#1
str r0,#65532
mov r0,#0
add r0,r0,#82
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#99
lsl r0,#8
add r0,r0,#107
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
mov r0,#0
add r0,r0,#44
lsl r0,#8
add r0,r0,#32
lsl r0,#8
add r0,r0,#112
lsl r0,#8
add r0,r0,#97
mov r1,#255
lsl r1,#8
add r1,r1,#12
str r0,[r1]
mov r0,#0
add r0,r0,#112
lsl r0,#8
add r0,r0,#101
lsl r0,#8
add r0,r0,#114
lsl r0,#8
add r0,r0,#44
mov r1,#255
lsl r1,#8
add r1,r1,#16
str r0,[r1]
mov r0,#0
add r0,r0,#32
lsl r0,#8
add r0,r0,#115
lsl r0,#8
add r0,r0,#99
lsl r0,#8
add r0,r0,#105
mov r1,#255
lsl r1,#8
add r1,r1,#20
str r0,[r1]
mov r0,#0
add r0,r0,#115
lsl r0,#8
add r0,r0,#115
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#114
mov r1,#255
lsl r1,#8
add r1,r1,#24
str r0,[r1]
mov r0,#0
add r0,r0,#115
lsl r0,#8
lsl r0,#8
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#28
str r0,[r1]
prints #65288
game:
mov r0,#0
add r0,r0,#67
lsl r0,#8
add r0,r0,#104
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#111
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
mov r0,#0
add r0,r0,#115
lsl r0,#8
add r0,r0,#101
lsl r0,#8
add r0,r0,#32
lsl r0,#8
add r0,r0,#49
mov r1,#255
lsl r1,#8
add r1,r1,#12
str r0,[r1]
mov r0,#0
add r0,r0,#32
lsl r0,#8
add r0,r0,#102
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#114
mov r1,#255
lsl r1,#8
add r1,r1,#16
str r0,[r1]
mov r0,#0
add r0,r0,#32
lsl r0,#8
add r0,r0,#114
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#99
mov r1,#255
lsl r1,#8
add r1,r1,#20
str r0,[r1]
mov r0,#0
add r0,r0,#107
lsl r0,#8
add r0,r0,#44
lsl r0,#8
add r0,r0,#32
lsl r0,#8
add r0,r0,#50
mov r1,#255
lsl r1,#8
add r1,r1,#24
str r0,[r1]
mov r0,#0
add r0,r0,#32
lsl r0,#8
add r0,r0,#102
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#114
mov r1,#255
lsl r1,#8
add r1,r1,#28
str r0,[r1]
mov r0,#0
add r0,r0,#32
lsl r0,#8
add r0,r0,#112
lsl r0,#8
add r0,r0,#97
lsl r0,#8
add r0,r0,#112
mov r1,#255
lsl r1,#8
add r1,r1,#32
str r0,[r1]
mov r0,#0
add r0,r0,#101
lsl r0,#8
add r0,r0,#114
lsl r0,#8
add r0,r0,#44
lsl r0,#8
add r0,r0,#32
mov r1,#255
lsl r1,#8
add r1,r1,#36
str r0,[r1]
mov r0,#0
add r0,r0,#51
lsl r0,#8
add r0,r0,#32
lsl r0,#8
add r0,r0,#102
lsl r0,#8
add r0,r0,#111
mov r1,#255
lsl r1,#8
add r1,r1,#40
str r0,[r1]
mov r0,#0
add r0,r0,#114
lsl r0,#8
add r0,r0,#32
lsl r0,#8
add r0,r0,#115
lsl r0,#8
add r0,r0,#99
mov r1,#255
lsl r1,#8
add r1,r1,#44
str r0,[r1]
mov r0,#0
add r0,r0,#105
lsl r0,#8
add r0,r0,#115
lsl r0,#8
add r0,r0,#115
lsl r0,#8
add r0,r0,#111
mov r1,#255
lsl r1,#8
add r1,r1,#48
str r0,[r1]
mov r0,#0
add r0,r0,#114
lsl r0,#8
add r0,r0,#115
lsl r0,#8
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#52
str r0,[r1]
prints #65288
inputn r0
ldr r2,#65532
mul r2.r2,#3
add r2,r2,#1
b .RND0:
.RND1:
sub r2,r2,#3
.RND0:
cmp r2,#3
bge .RND1
str r2,#65532
mov r1,r2
add r2,r0,#1
sub r0,r2,r1
cmp #2,r0
beq .L0
b .L1
.L0:
mov r0,#0
add r0,r0,#68
lsl r0,#8
add r0,r0,#82
lsl r0,#8
add r0,r0,#65
lsl r0,#8
add r0,r0,#87
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
mov r0,#0
lsl r0,#8
lsl r0,#8
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#12
str r0,[r1]
prints #65288
.L1:
add r2,r0,#1
sub r0,r2,r1
cmp #1,r0
beq .L2
b .L3
.L2:
mov r0,#0
add r0,r0,#76
lsl r0,#8
add r0,r0,#79
lsl r0,#8
add r0,r0,#83
lsl r0,#8
add r0,r0,#83
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
mov r0,#0
lsl r0,#8
lsl r0,#8
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#12
str r0,[r1]
prints #65288
.L3:
add r2,r0,#1
sub r0,r2,r1
cmp #4,r0
beq .L4
b .L5
.L4:
mov r0,#0
add r0,r0,#76
lsl r0,#8
add r0,r0,#79
lsl r0,#8
add r0,r0,#83
lsl r0,#8
add r0,r0,#83
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
mov r0,#0
lsl r0,#8
lsl r0,#8
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#12
str r0,[r1]
prints #65288
.L5:
add r2,r0,#1
cmp r1,r2
beq .L6
b .L7
.L6:
mov r0,#0
add r0,r0,#87
lsl r0,#8
add r0,r0,#73
lsl r0,#8
add r0,r0,#78
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
prints #65288
.L7:
add r2,r0,#1
sub r0,r2,r1
cmp #3,r0
beq .L8
b .L9
.L8:
mov r0,#0
add r0,r0,#87
lsl r0,#8
add r0,r0,#73
lsl r0,#8
add r0,r0,#78
lsl r0,#8
mov r1,#255
lsl r1,#8
add r1,r1,#8
str r0,[r1]
prints #65288
.L9:
mov r0,#0
add r0,r0,#65
lsl r0,#8
add r0,r0,#110
lsl r0,#8
add r0,r0,#111
lsl r0,#8
add r0,r0,#116
mov r2,#255
lsl r2,#8
add r2,r2,#8
str r0,[r2]
mov r0,#0
add r0,r0,#104
lsl r0,#8
add r0,r0,#101
lsl r0,#8
add r0,r0,#114
lsl r0,#8
add r0,r0,#32
mov r2,#255
lsl r2,#8
add r2,r2,#12
str r0,[r2]
mov r0,#0
add r0,r0,#103
lsl r0,#8
add r0,r0,#97
lsl r0,#8
add r0,r0,#109
lsl r0,#8
add r0,r0,#101
mov r2,#255
lsl r2,#8
add r2,r2,#16
str r0,[r2]
mov r0,#0
add r0,r0,#63
lsl r0,#8
lsl r0,#8
lsl r0,#8
mov r2,#255
lsl r2,#8
add r2,r2,#20
str r0,[r2]
prints #65288
inputs r14
mov r0,r14
b .INP0
.INP1:
add r14,r14,#1
.INP0:
ldr r2,[r14]
cmp r2,#0
bne .INP1
add r14,r14,#2
mov r3,#0
b .STREQ0
.STREQ1
add r3,r3,#1
.STREQ0:
ldr r4,[r0,r3]
ldr r5,[r2,r3]
cmp r4,#0
beq .STREQ2
cmp r4,r5
beq .STREQ1
b .STREQ3
.STREQ2:
cmp r5,#0
bne .STREQ3
b game
.STREQ3:
andeq r0,r0,r0
