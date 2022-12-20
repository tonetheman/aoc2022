
import tonyutils
import strutils

type
    Node = object
        val : int
        snum : int

proc repr(data : seq[Node]) : string =
    var ts : string
    for d in data:
        ts = ts & " " & $d.val
    return ts

proc find_snum_index(data: seq[Node], target_snum : int) : int =
    for i in 0 ..< len(data):
        if data[i].snum == target_snum:
            return i
    # if you got here there is a problem
    system.quit(-1)

proc part1() =
    var fdata = makefilebuffer("sample.txt")
    var data : seq[Node] = newSeq[Node](len(fdata))
    for i in 0 ..< len(fdata):
        data[i].snum = i
        data[i].val = parseInt(fdata[i])

    echo("init arrangment: ",data.repr())

    let ll = len(data)
    for i in 0 ..< len(data):
        echo("working on i: ",i)

        # find the orig Node with snum == i
        let target_snum = i
        var index = find_snum_index(data,target_snum)
        echo("\tindex is: ",index)

        var val = data[index]
        if val.val == 0:
            continue
        var num : int
        num = index + val.val + 1
        if val.val<0:
            num = index + (ll-val.val+1)
        echo("\t",val," ",num)
        data.insert(val,num mod ll)
        data.delete(index)
        echo("\t",data.repr())
        
    echo(data.repr())

part1()

proc test1() =
    var a = @[1,2,-3,3,-2,0,4]

    let ll = len(a)
    echo("len of a is ",ll)

    # NOTE
    # this is correct
    # just need a way to make sure
    # index is set correctly

    var index = 0 # hard coded
    var val = a[index]
    var num : int
    num = index + val + 1
    if val<0:
        num = index + (ll-val+1)
    a.insert(val,num mod 11)
    a.delete(index)
    echo(a)

    index = 0 # hard coded
    val = a[index]
    num = index + val + 1
    if val<0:
        num = index + (ll-val+1)
    a.insert(val,num mod ll)
    a.delete(index)
    echo(a)

    index = 1 # hard coded
    val = a[index]
    num = index + val + 1
    if val<0:
        num = index + (ll-val+1)
    a.insert(val, num mod ll)
    a.delete(index)
    echo(a)

    
# test1()

proc test2() =
    # checking the math
    let ll = 3
    for i in -1 ..< 10:
        var num = i
        if i<0:
            num = ll-i+1
        echo(num mod ll)