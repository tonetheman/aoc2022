import tonyutils

let fdata = makefilebuffer("sample.txt")
let rowlen = len(fdata[0])
let collen = len(fdata)

type atype = enum empty, wall, blizRight, blizLeft, blizUp, blizDown

# build grid empty
var grid = newSeq[ seq[atype] ](7)
for i in 0 ..< rowlen:
    grid[i] = newSeq[atype](collen)

var rowindex = 0
var colindex = 0
for line in fdata:
    for c in line:
        if c == '#':
            grid[rowindex][colindex] = wall
        elif c == '.':
            grid[rowindex][colindex] = empty
        elif c == '>':
            grid[rowindex][colindex] = blizRight
        elif c == '<':
            grid[rowindex][colindex] = blizLeft
        elif c == 'v':
            grid[rowindex][colindex] = blizDown
        elif c == '^':
            grid[rowindex][colindex] = blizUp
        colindex += 1
    rowindex += 1
    colindex = 0

for line in grid:
    echo(line)