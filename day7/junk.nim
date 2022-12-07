
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
        parent : ptr SantaFile
        entries : seq[SantaFile]

# assume we start at root
var root = SantaFile(name:"/",size:0,isdir:true,isfile:false,parent:nil)
var current_dir : ptr SantaFile = addr(root)
var state : State

proc dir_exists(name:string) : bool =
    for v in current_dir.entries:
        if v.name == name:
            return true
    return false

proc parse_command(cdata : seq[string]) =
    if cdata[1] == "cd":
        if cdata[2] == "/":
            # switched to outermost root
            current_dir = addr(root)
        elif cdata[2] == "..":
            if current_dir.parent == nil:
                echo("DBG: err cannot move up parent is nil",current_dir.name)
                system.quit(0)
            else:
                current_dir = current_dir.parent
        else:
            for e in current_dir.entries.mitems:
                if e.name == cdata[2]:
                    current_dir = addr(e)
                    return

    elif cdata[1] == "ls":
        state = stLs


############################################
############################################
let data = makefilebuffer("sample.txt")

for line in data:

    let cdata = line.split(" ")

    if state == stStart:
        if line.startsWith("$"):
            # command!
            parse_command(cdata)

    if state == stLs:
        if cdata[0] == "$":
            state = stStart
            # this will change the state if needed
            parse_command(cdata)
            # we are done
            continue

        if cdata[0] == "dir":
            # check if this directory is already in entries
            let res = dir_exists(cdata[1])
            if res == false:
                var tmp = SantaFile(name:cdata[1],isdir:true,
                    isfile:false,size:0,parent:current_dir)
                current_dir.entries.add(tmp)
            else:
                echo("DBG: dir was already present?",cdata)
                system.quit(-1)
        else:
            # hate this assuming it is a number
            let size = parseInt(cdata[0])
            let name = cdata[1]
            var tmp = SantaFile(name:name,size:size,isfile:true,isdir:false,parent:nil)
            current_dir.entries.add(tmp)

proc print_sizes(pp : ptr SantaFile) =
    echo(pp.name, " ", pp.size)
    for e in pp.entries.mitems:
        if e.isdir:
            print_sizes(addr(e))

proc clear_sizes(pp : ptr SantaFile) =
    pp.size = 0
    for e in pp.entries.mitems:
        if e.isdir:
            clear_sizes(addr(e))

proc addup_sizes(pp : ptr SantaFile) =
    var total_size = 0
    for e in pp.entries.mitems:
        if e.isdir:
            addup_sizes(addr e)
            total_size += e.size
        else:
            total_size += e.size
    pp.size = total_size


proc part1() = 
    var part1_total = 0

    proc part1(pp : ptr SantaFile) =
        if pp.name != "/":
            if pp.size < 100000:
                echo(pp.name, " ", pp.size)
                part1_total += pp.size
        for e in pp.entries.mitems:
            if e.isdir:
                part1(addr e)

    clear_sizes(addr root)
    addup_sizes(addr root)
    print_sizes(addr root)
    part1(addr root)

    echo("part1 result: ",part1_total)

proc pp(myroot : ptr SantaFile, level : int) =
    echo(level, " ", myroot.name, " ", myroot.size)
    for e in myroot.entries.mitems:
        if e.isdir:
            pp(addr(e),level+1)

# just playing to make a better pretty printer
proc pretty(myroot : ptr SantaFile) =
    pp(myroot,0)

clear_sizes(addr root)
addup_sizes(addr root)
pretty(addr root)