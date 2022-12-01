import strutils
import std/algorithm

proc p1() =
    let inf = open("input.txt")
    defer: inf.close()

    var largest = -1
    var current_elf = 0
    var line : string
    while inf.read_line(line):
        if line == "":
            if current_elf > largest:
                largest = current_elf
            current_elf = 0
        else:
            current_elf += parseInt(line)

    echo("part1")
    echo("largest: ",largest)
    echo("")

p1()

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

    echo("part2")
    echo("largest: ",largest)
    alle.sort()

    echo("top 3: ", alle[^1] + alle[^2] + alle[^3])

p2()