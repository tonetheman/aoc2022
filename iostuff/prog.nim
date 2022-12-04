
import std/streams

proc p1() =
    let inf = newFileStream("sample.txt", fmRead)
    defer: inf.close()

    var line : string
    if not isNil(inf):
        while inf.readLine(line):
            echo(line)


p1()