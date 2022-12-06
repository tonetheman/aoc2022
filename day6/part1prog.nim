
proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

proc alldiff(b:array[4,char]):bool =
    if b[0]==b[1] or b[0]==b[2] or b[0]==b[3]:
        return false
    if b[1]==b[0] or b[1]==b[2] or b[1]==b[3]:
        return false
    if b[2]==b[0] or b[2]==b[1] or b[2]==b[3]:
        return false
    if b[3]==b[0] or b[3]==b[1] or b[3]==b[2]:
        return false
    return true

proc scan(s:string):int =
    var mb : array[4,char] # a buffer for the marker
    const START_INDEX = 3
    var index = START_INDEX

    while true:
        mb[0] = s[index-3]
        mb[1] = s[index-2]
        mb[2] = s[index-1]
        mb[3] = s[index]

        let res = alldiff(mb)

        # echo(index)
        # echo(mb)
        # echo(res)
        # echo("")

        if res:
            return index + 1

        index += 1

        if index==len(s):
            break

    return -1

proc test() =
    let data = makefilebuffer("sample.txt")
    assert 7==scan(data[0])
    assert 5==scan(data[1])
    assert 6==scan(data[2])
    assert 10==scan(data[3])
    assert 11==scan(data[4])

test()

proc p1() =
    let data = makefilebuffer("input.txt")
    echo("part1 answer: ",scan(data[0]))

p1()