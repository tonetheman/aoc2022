
type
    Rock = seq[ seq[int] ]

# AGAIN I RUN INTO THIS WTF DOES THIS LINE DO?
# it is not doing what I think it should at all
var r0 : Rock = newSeq[ newSeq[int](4) ](1)
# why do you need this?
r0[0] = newSeq[int](4)

r0[0][0] = 1
r0[0][1] = 1
r0[0][2] = 1
r0[0][3] = 1

for i in r0:
    echo(i)

var r1 = newSeq[ newSeq[int](3)](3)
r1[0] = newSeq[int](3)
r1[1] = newSeq[int](3)
r1[2] = newSeq[int](3)
r1[0][1] = 1
r1[1][0] = 1
r1[1][1] = 1
r1[1][2] = 1
r1[2][1] = 1
for i in r1:
    echo(i)

var r2 = newSeq[ newSeq[int](3)](3)
r2[0] = newSeq[int](3)
r2[1] = newSeq[int](3)
r2[2] = newSeq[int](3)
r2[0][2] = 1
r2[1][2] = 1
r2[2][0] = 1
r2[2][1] = 1
r2[2][2] = 1
for i in r2:
    echo(i)

var r3 = newSeq[ newSeq[int](1)](4)
r3[0] = newSeq[int](1)
r3[1] = newSeq[int](1)
r3[2] = newSeq[int](1)
r3[3] = newSeq[int](1)
r3[0][0] = 1
r3[1][0] = 1
r3[2][0] = 1
r3[3][0] = 1
for i in r3:
    echo(i)

var r4 = newSeq[newSeq[int](2)](2)
r4[0] = newSeq[int](2)
r4[1] = newSeq[int](2)
r4[0][0] = 1
r4[0][1] = 1
r4[1][0] = 1
r4[1][1] = 1
for i in r4:
    echo(i)

var rocks* = newSeq[Rock](5)
rocks[0] = r0
rocks[1] = r1
rocks[2] = r2
rocks[3] = r3
rocks[4] = r4