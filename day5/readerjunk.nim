
import strutils
import std/algorithm

proc parse_starting_data(inputfile:string)

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

proc testcompiletime() =
    parse_starting_data("sample.txt")
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



# this is a better way to read the inputs
proc parse_starting_data(inputfile : string) =
    
    # read file input memory
    var buffer = makefilebuffer(inputfile)

    # find the first move index in the buffer
    var index = findfirstmove(buffer)
    
    # back up to the counts
    index -= 2
    let data = buffer[index].strip().split(" ")

    # this is the number of stacks we need
    let needed_stacks = parseInt(data[^1])

    # THIS fails because array must have a compile time
    # constant
    # TODO: can i do that? no reason I could not really
    # so that is the question!!!!!
    # can i run the first part of my code at compile time?
    # var stacks : array[needed_stacks+1, seq[char]]

    var stacks : seq[ seq[char] ]
    for i in 0 .. needed_stacks:
        var tmp = newSeq[char]()
        stacks.add(tmp)
    
    # note we are allocating a stack at pos 0
    # or in other words one extra stack
    # that is not really used
    # because move data is 1 based

    index = findfirstmove(buffer)
    index -= 1 # should be blank
    index -= 1 # now on numbers line

    # this is the stack data
    for i in 0 ..< index:
        # grab the data name it something
        let line = buffer[i]
        var start = 1 # position inside of line pointing to data
        var stackid = 1 # stack we need to put it in
        while true:
            # skip the blanks
            if line[start] != ' ':
                stacks[stackid].add(line[start])
            # bump up the stack
            stackid += 1
            # move inside the line to next data
            start += 4
            # quit if ya need to
            if start>len(line):
                break
    # reverse the stacks
    for s in stacks.mitems:
        s.reverse()

    echo("final stacks")
    echo(stacks)

    
parse_starting_data("input.txt")
