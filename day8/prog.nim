
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
    
proc see(a : seq[ seq[int] ], r,c : int) : int =
    let rows = len(a)
    let cols = len(a[0])

    # look down
    var ll = r+1
    var mval = a[r][c]
    var count1 = 0
    while ll<rows:
        # echo("checking: ",ll," ",c," ",a[ll][c])
        if a[ll][c] < mval:
            ll += 1
            count1 += 1
            continue
        else:
            count1 += 1
            break
    # echo("down count: ", count1)

    # look right
    ll = c+1
    mval = a[r][c]
    var count2 = 0
    # echo("ll value: ",ll)
    # echo("c value: ",c)
    while ll<cols:
        # echo("checking: ",r," ",ll," ",a[r][ll])
        if a[r][ll] < mval:
            ll += 1
            count2 += 1
            continue
        else:
            count2 += 1
            break
    # echo("right count: ",count2)

    # look left
    ll = c-1
    mval = a[r][c]
    var count3 = 0
    while ll>=0:
        if a[r][ll] < mval:
            ll -= 1
            count3 += 1
            continue
        else:
            count3 += 1
            break
    # echo("left count: ",count3)

    # look up
    ll = r-1
    mval = a[r][c]
    var count4 = 0
    while ll>=0:
        if a[ll][c] < mval:
            ll -= 1
            count4 += 1
            continue
        else:
            count4 += 1
            break
    # echo("up count: ",count4)

    return count1 * count2 * count3 * count4


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


proc part1() =
    # data from file
    let data = makefilebuffer("input.txt")
    # create the grid
    let a = creategrid(data)
    let res = count(a)
    echo("res: ",res)

proc part2() =
    let data = makefilebuffer("input.txt")
    var maxvalue = -1
    let a = creategrid(data)
    for i in 0 ..< len(a):
        for j in 0 ..< len(a[0]):
            let res = see(a,i,j)
            if res>maxvalue:
                maxvalue = res
    echo("final max: ",maxvalue)

part2()