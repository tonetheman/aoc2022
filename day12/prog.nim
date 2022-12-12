
import tonyutils
import strformat

proc part1() =
    let data = makefilebuffer("sample.txt")

    # make rows
    var grid = newSeq[ seq[int] ](5)   

    # make cols
    for i in 0 ..< 5:
        grid[i] = newSeq[int](8)

    # fill the grid out from the sample
    var index = 0
    for i in 0 ..< 5:
        var j = 0
        for c in data[index]:
            if c=='S':
                grid[i][j] = 0
            elif c=='E':
                grid[i][j] = ord('z')-ord('a')
            else:
                grid[i][j] = ord(c)-ord('a')
            j += 1
        index += 1

    proc printgrid() =
        for i in 0 ..< 5:
            for j in 0 ..< 8:
                stdout.write( &("{grid[i][j]:3}") )
            stdout.write("\n")

    printgrid()





part1()