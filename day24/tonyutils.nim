proc makefilebuffer*(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

proc creategrid*(data : seq[string]) : seq[ seq[int] ] =
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
