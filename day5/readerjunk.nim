
import strutils

proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    var index = 0
    for line in lines(inputfile):
        buffer.add(line)
        index += 1
    return buffer

proc findfirstmove(buffer : seq[string]) : int =
    var index = 0
    for line in buffer:
        if line.startsWith("move"):
            break
        index += 1
    return index

proc computeneededstacks(inputfile:string) : int =
    let buffer = makefilebuffer(inputfile)
    var index = findfirstmove(buffer)
    index -= 2
    let data = buffer[index].strip().split(" ")
    return parseInt(data[^1])

proc test(inputfile : string) =
    
    var buffer = makefilebuffer(inputfile)

    echo(buffer)

    var index = findfirstmove(buffer)
    
    # back up to the counts

    index -= 2
    echo("index is: ", index)
    echo(buffer[index])
    let data = buffer[index].strip().split(" ")
    echo(data)
    let needed_stacks = parseInt(data[^1])
    echo("need this many stacks: ", needed_stacks)

    # THIS fails because array must have a compile time
    # constant
    # TODO: can i do that? no reason I could not really
    # so that is the question!!!!!
    # can i run the first part of my code at compile time?
    # var stacks : array[needed_stacks+1, seq[char]]

proc testcompiletime() =
    test("sample.txt")
    echo(computeneededstacks("sample.txt"))
    # this will not compile!
    # complains about importc variable fopen
    # maybe you cannot do io at compile time?
    # let i = static(computeneededstacks("sample.txt"))

    # another try also fails to compile
    # var i : int
    #static:
    #    discard computeneededstacks("sample.txt")
    #var junk : array[i,int]