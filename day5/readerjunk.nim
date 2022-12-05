
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

test("sample.txt")
