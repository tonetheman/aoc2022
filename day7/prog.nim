
import strutils

# i need to make this a module
proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

type
    SantaFile = object
        directory : string
        name : string
        size : int

let data = makefilebuffer("sample.txt")

# assume we start at root
var current_dir = "/"
var allfiles : seq[SantaFile]

for line in data:
    if line.startsWith("$"):
        # command!
        let cdata = line.split(" ")
        if cdata[0] != "$":
            echo("ERR: invalid command!",line)
            system.quit(-1)
        if cdata[1] == "cd":
            if cdata[2] == "/":
                # switched to outermost root
                current_dir = "/"
            else:
                # went to a directory down or up!
                discard
        elif cdata[1] == "ls":
            discard                
    else:
        # result I think
        discard

