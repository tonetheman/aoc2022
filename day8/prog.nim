
import strutils

proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

proc fileseq(data : seq[string]) : seq[ seq[int] ] =
    let rows = len(data)
    let cols = len(data[0])

    var a : seq[ seq[int] ] = newSeq[newSeq[int](cols)](rows)
    var rowindex = 0
    for line in data:
        var colindex = 0
        for c in line:
            # WTF why did this not work?
            # a[rowindex][colindex] = ord(c)-ord('0')
            a[rowindex].add(ord(c)-ord('0'))
            colindex += 1
        rowindex += 1
    return a

proc vis(a : seq[ seq[int] ], r,c : int) : bool = 
    let me = a[r][c]
    # check left
    var ll = 0
    while ll < c:
        echo("checking ",r, " ",ll, a[r][ll])
        if a[r][ll] < me:
            ll += 1
        else:
            return false
    return true

# data from file
let data = makefilebuffer("sample.txt")
echo(data)
# rows and cols
let rows = len(data)
let cols = len(data[0])
# create the grid
let a = fileseq(data)
echo(a)
echo(vis(a,1,1))
