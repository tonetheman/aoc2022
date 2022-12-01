import strutils
import std/algorithm

proc p1() =
    let inf = open("input.txt")
    defer: inf.close()

    var largest = -1
    var current_elf = 0
    var line : string
    while inf.read_line(line):
        echo(line)
        if line == "":
            echo("break")
            if current_elf > largest:
                largest = current_elf
            current_elf = 0
        else:
            current_elf += parseInt(line)

    echo("largest: ",largest)

# p1()

proc p2() =
    let inf = open("input.txt")
    defer: inf.close()
    var alle = newSeq[int]()

    var largest = -1
    var current_elf = 0
    var line : string
    while inf.read_line(line):
        if line == "":
            if current_elf > largest:
                largest = current_elf
            alle.add(current_elf)
            current_elf = 0
        else:
            current_elf += parseInt(line)

    if current_elf>0:
        alle.add(current_elf)

    echo("largest: ",largest)
    alle.sort()

    let ll = len(alle)
    echo("top 3: ", alle[ll-1] + alle[ll-2] + alle[ll-3])

p2()