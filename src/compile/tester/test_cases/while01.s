mov r0,#1
b .L0
.L1:
mov r1,#0
add r1,r1,#72
lsl r1,#8
add r1,r1,#69
lsl r1,#8
add r1,r1,#76
lsl r1,#8
add r1,r1,#76
mov r2,#255
lsl r2,#8
add r2,r2,#8
str r1,[r2]
mov r1,#0
add r1,r1,#79
lsl r1,#8
add r1,r1,#32
lsl r1,#8
add r1,r1,#87
lsl r1,#8
add r1,r1,#79
mov r2,#255
lsl r2,#8
add r2,r2,#12
str r1,[r2]
mov r1,#0
add r1,r1,#82
lsl r1,#8
add r1,r1,#76
lsl r1,#8
add r1,r1,#68
lsl r1,#8
mov r2,#255
lsl r2,#8
add r2,r2,#16
str r1,[r2]
prints #65288
add r1,r0,#1
mov r0,r1
.L0:
cmp #5,r0
ble .L2
b .L3
.L2:
b .L1
.L3:
andeq r0,r0,r0