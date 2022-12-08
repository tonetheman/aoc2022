
import strutils

proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

proc creategrid(data : seq[string]) : seq[ seq[int] ] =
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
    var ll = 0
    var good : bool

    good = true
    ll = 0
    while ll < c:
        if a[r][ll] < me:
            ll += 1
            continue
        else:
            good = false
            break
    # echo("good chaeck Left: ",good)
    if good:
        return true

    good = true
    ll = 0
    while ll < r:
        if a[ll][c]<me:
            ll += 1
            continue
        else:
            good = false
            break
    # echo("good value for top check: ",good)
    if good:
        return true

    good = true
    ll = len(a[0])-1
    while ll>c:
        # echo("R:checking: ",r, " ",ll," ",a[r][ll])
        if a[r][ll]<me:
            ll -= 1
            continue
        else:
            good = false
            break
    # echo("GOOD value for RIGHT CHECK: ", good)
    if good: return true

    good = true
    ll = len(a)-1
    while ll>r:
        # echo("B:checking: ",ll," ",c," ",a[ll][c])
        if a[ll][c]<me:
            ll -= 1
            continue
        else:
            good = false
            break
    # echo("GOOD VALUE FOR B check: ", good)
    if good: return true
    

proc count(a : seq[ seq[int] ]) : int =
    let rows = len(a)
    let cols = len(a[0])

    # outside ring first
    var res = 2*rows + 2*(cols-2)

    # now count inside trees
    for i in 1 .. cols-2:
        for j in 1 .. rows-2:
            if vis(a,i,j):
                res += 1
    return res


# data from file
let data = makefilebuffer("input.txt")
echo(data)

# create the grid
let a = creategrid(data)
let res = count(a)
echo("res: ",res)
