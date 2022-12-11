import tonyutils
import strutils
import std/tables

type
    HeadOrHead = object
        row, col : int

let data = makefilebuffer("sample.txt")

var head : HeadOrHead
var tail : HeadOrHead
var v = initTable[HeadOrHead,int]()
v[head] = 1

proc checkdist() = 
    let r = head.row-tail.row
    let c = head.col-tail.col
    echo(r,c)

for line in data:
    let ldata = line.split(" ")
    echo(ldata)

    let direction = ldata[0]
    let steps = parseInt(ldata[1])

    for i in 0 ..< steps:
        if direction == "R":
            head.col = head.col + 1
            v[head] = 1
        elif direction == "L":
            head.col = head.col - 1
            v[head] = 1
        elif direction == "U":
            head.row = head.row - 1
            v[head] = 1
        elif direction == "D":
            head.row = head.row + 1
            v[head] = 1

    break

echo(v)
echo(len(v))