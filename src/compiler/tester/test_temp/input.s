mov r0,#2003329396
str r0,=0xff08
mov r0,#661856377
str r0,=0xff0c
mov r0,#1869967904
str r0,=0xff10
mov r0,#1851878757
str r0,=0xff14
mov r0,#1056964608
str r0,=0xff18
prints #65288
inputs r14
mov r0,r14
b .INP0
.INP1:
add r14,r14,#1
.INP0:
ldr r1,[r14]
cmp r1,#0
bne .INP1
add r14,r14,#2
mov r1,#1752135456
str r1,=0xff08
mov r1,#1869374496
str r1,=0xff0c
mov r1,#1634886944
str r1,=0xff10
mov r1,#2037347647
str r1,=0xff14
mov r1,#0
str r1,=0xff18
prints #65288
inputn r1
mov r2,#1851878757
str r2,=0xff08
mov r2,#973078528
str r2,=0xff0c
prints #65288
prints r0
mov r2,#1634166074
str r2,=0xff08
mov r2,#0
str r2,=0xff0c
prints #65288
printn r1
andeq r0,r0,r0
