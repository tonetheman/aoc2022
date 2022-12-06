
proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

proc alldiff(b:array[14,char]):bool =

    proc dupcheck(target:int):bool =
        for i in 0 .. 13:
            if target==i:
                continue
            if b[target]==b[i]:
                return true
        return false

    for i in 0 .. 13:
        if dupcheck(i):
            return false

    return true

proc scan(s:string):int =
    var mb : array[14,char] # a buffer for the marker
    const START_INDEX = 13
    var index = START_INDEX

    while true:
        mb[0] = s[index-13]
        mb[1] = s[index-12]
        mb[2] = s[index-11]
        mb[3] = s[index-10]
        mb[4] = s[index-9]
        mb[5] = s[index-8]
        mb[6] = s[index-7]
        mb[7] = s[index-6]
        mb[8] = s[index-5]
        mb[9] = s[index-4]
        mb[10] = s[index-3]
        mb[11] = s[index-2]
        mb[12] = s[index-1]
        mb[13] = s[index]

        let res = alldiff(mb)

        
        echo(index)
        echo(mb)
        echo(res)
        echo("")

        if res:
            return index + 1

        index += 1

        if index==len(s):
            break

    return -1

proc test() =
    let data = makefilebuffer("sample.txt")
    assert 19==scan(data[0])
    assert 23==scan(data[1])
    assert 23==scan(data[2])
    assert 29==scan(data[3])
    assert 26==scan(data[4])

test()

proc p1() =
    let data = makefilebuffer("input.txt")
    echo("part1 answer: ",scan(data[0]))

p1()