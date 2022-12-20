
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