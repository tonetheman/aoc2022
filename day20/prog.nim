
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

        # get copy of orig node
        var val = data[index]
        # for 0 values do nothing
        if val.val == 0:
            continue

        var num : int

        # new position
        num = index + val.val + 1
        # handle negatives
        if val.val<0:
            num = index + (ll-val.val+1)
        
        echo("\t",val," ",num)

        # real move and delete here
        data.insert(val,num mod ll)
        data.delete(index)
        
        # debug
        echo("\t",data.repr())
        
    echo(data.repr())

part1()
