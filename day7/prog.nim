
import strutils

# i need to make this a module
proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer


let data = makefilebuffer("sample.txt")
for line in data:
    if line.startsWith("$"):
        # command!
        discard
    else:
        # result I think
        discard

