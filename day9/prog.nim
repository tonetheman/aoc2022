import tonyutils
import strutils
import std/tables

const
    ROWS = 10
    COLS = 10
    
type
    HeadTail = object
        hrow, hcol : int
        trow, tcol : int

    Position = object
        row, col : int

proc istouching_rowcol(ht : ptr HeadTail) : bool =
    # are the on the same spot
    # then they are touching
    if ht.trow == ht.hrow and ht.tcol == ht.hcol:
        return true

    # they are in the same row
    if ht.trow-1 == ht.hrow or ht.trow+1 == ht.hrow:
        return true

    # they are in the same col
    if ht.tcol-1 == ht.hcol or ht.tcol+1 == ht.hcol:
        return true

    return false

proc istouching_diag(ht : ptr HeadTail) : bool =
    # left top
    if ht.trow == ht.hrow-1 and ht.tcol == ht.hcol-1:
        return true
    # right top
    if ht.trow == ht.hrow-1 and ht.tcol == ht.hcol+1:
        return true
    # ibottom left
    if ht.trow == ht.hrow+1 and ht.tcol == ht.hcol-1:
        return true
    if ht.trow == ht.hrow+1 and ht.tcol == ht.hcol+1:
        return true

    return false


proc step(inst:string, map : ptr Table[Position,int], ht : ptr HeadTail) =
    let idata = inst.split(" ")
    let direction = idata[0]
    var count = parseInt(idata[1])
    # starting head position

    while count > 0:

        # move single step head
        if direction == "R":
            ht.hrow += 1
        elif direction == "L":
            ht.hrow -= 1
        elif direction == "U":
            ht.hcol -= 1
        elif direction == "D":
            ht.hcol += 1
        
        # move single step tail
        if istouching_rowcol(ht):
            discard


        count -= 1
    
    echo("done with movement for: ",inst)


proc part1() =
    let data = makefilebuffer("sample.txt")

    var map : Table[Position,int]

    var ht : HeadTail
    echo(ht)
    var index = 0
    map.add(Position(row:0,col:0),1) # tail starts here
    step(data[index], addr(map), addr(ht))



part1()
