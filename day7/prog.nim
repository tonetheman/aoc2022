
import strutils

# i need to make this a module
proc makefilebuffer(inputfile:string) : seq[string] =
    var buffer : seq[string]
    for line in lines(inputfile):
        buffer.add(line)
    return buffer

type
    State = enum
        stStart, stLs
    SantaFile = object
        name : string
        size : int
        isdir : bool
        isfile : bool
        entries : seq[SantaFile]

# assume we start at root
var root = SantaFile(name:"/",size:0,isdir:true,isfile:false)
var current_dir : ptr SantaFile = addr(root)
var current_parsing_dir : ptr SantaFile

proc dir_exists(name:string) : bool =
    for v in current_dir.entries:
        if v.name == name:
            return true
    return false

let data = makefilebuffer("sample.txt")

var state : State
for line in data:

    if state == stStart:
        if line.startsWith("$"):
            # command!
            let cdata = line.split(" ")
            echo("DBG: stStart: cdata: ",cdata)

            if cdata[0] != "$":
                echo("ERR: invalid command!",line)
                system.quit(-1)
            if cdata[1] == "cd":
                if cdata[2] == "/":
                    # switched to outermost root
                    current_dir = addr(root)
                    echo("DBG: switched curren_dir to root")
                else:
                    # went to a directory down or up!
                    discard
                continue # have handled this command
            elif cdata[1] == "ls":
                state = stLs
                continue  # switched state and handled this command

    if state == stLs:
        let cdata = line.split(" ")
        echo("DBG: stLs: cdata: ",cdata)
        if cdata[0] == "dir":
            # check if this directory is already in entries
            let res = dir_exists(cdata[1])
            if res == false:
                echo("DBG: dir does not exist need to create")
                var tmp = SantaFile(name:cdata[1],isdir:true,isfile:false,size:0)
                current_dir.entries.add(tmp)
            else:
                discard
        else:
            # hate this assuming it is a number
            let size = parseInt(cdata[0])
            let name = cdata[1]


echo("DBG: final")
echo(root)