import tonyutils

const
    ROWS = 10
    COLS = 10
    
type
    HeadTail = object
        hrow, hcol : int
        trow, tcol : int

proc step(inst:string) =
    discard

proc part1() =
    let data = makefilebuffer("sample.txt")

    var ht : HeadTail
    echo(ht)
    var index = 0
    step(data[index])



part1()
