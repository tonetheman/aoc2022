

proc test1() =
    let inf = open("test.txt")
    echo("type of inf: ",typeof(inf))
    defer: inf.close()

    var line : string
    if inf.read_line(line):
        echo(line)
    let badassign = line

    if inf.read_line(line):
        echo(line) 

    echo("read line typeof is: ", typeof(line))

    let badassign2 = line

    echo(badassign," ",badassign2)

proc test2() =
    var line : string = "abc"
    let b1 = line
    line = "def"
    let b2 = line

    echo("b1 and b2 ",b1," ",b2)

test1()
test2()
