
import std/algorithm
import strutils

# stupid but only works for sample
proc p1sample(inputfile: string) =
    var breakpointhit = false

    var stacks : array[4, seq[char]]
    var s1 : seq[char]
    var s2 : seq[char]
    var s3 : seq[char]

    # just handles the setup
    for line in lines(inputfile):
        
        if line == "":
            breakpointhit = true
            # just stop once you get the blank line
            break

        if breakpointhit:
            echo("***----****: ", line)
        else:
            echo(line[1], " ", line[5], " ", line[9])
            if line[1] != ' ':
                s1.add(line[1])
            if line[5] != ' ':
                s2.add(line[5])
            if line[9] != ' ':
                s3.add(line[9])

    echo("stacks are")
    s1.reverse()
    s2.reverse()
    s3.reverse()
    echo(s1)
    echo(s2)
    echo(s3)
    stacks[1] = s1
    stacks[2] = s2
    stacks[3] = s3

    echo(stacks)
    echo("STARTING MOVE PROCESSING")

    # now handle instructions
    breakpointhit = false
    for line in lines(inputfile):

        if line == "":
            breakpointhit = true
            continue

        if breakpointhit:
            let data = line.split(" ")
            var num_to_move = parseInt(data[1])
            let src = parseInt(data[3])
            let dst = parseInt(data[5])

            while num_to_move > 0:
                let val = stacks[src].pop()
                stacks[dst].add(val)
                num_to_move -= 1

            

    echo("stacks at end")
    echo(stacks)
    var res : string
    for i in 1 .. 3:
        res = res & stacks[i][^1]
    echo(res)


# p1sample("sample.txt")


proc p1part1(inputfile: string) =
    var breakpointhit = false

    var stacks : array[10, seq[char]]
    var s1 : seq[char]
    var s2 : seq[char]
    var s3 : seq[char]
    var s4 : seq[char]
    var s5 : seq[char]
    var s6 : seq[char]
    var s7 : seq[char]
    var s8 : seq[char]
    var s9 : seq[char]

    # just handles the setup
    for line in lines(inputfile):
        
        if line == "":
            breakpointhit = true
            # just stop once you get the blank line
            break

        if breakpointhit:
            echo("***----****: ", line)
        else:
            echo(line[1], " ", line[5], " ", line[9])
            if line[1] != ' ':
                s1.add(line[1])
            if line[5] != ' ':
                s2.add(line[5])
            if line[9] != ' ':
                s3.add(line[9])
            if line[13] != ' ':
                s4.add(line[13])
            if line[17] != ' ':
                s5.add(line[17])
            if line[21] != ' ':
                s6.add(line[21])
            if line[25] != ' ':
                s7.add(line[25])
            if line[29] != ' ':
                s8.add(line[29])
            if line[33] != ' ':
                s9.add(line[33])

    echo("stacks are")
    s1.reverse()
    s2.reverse()
    s3.reverse()
    s4.reverse()
    s5.reverse()
    s6.reverse()
    s7.reverse()
    s8.reverse()
    s9.reverse()
    stacks[1] = s1
    stacks[2] = s2
    stacks[3] = s3
    stacks[4] = s4
    stacks[5] = s5
    stacks[6] = s6
    stacks[7] = s7
    stacks[8] = s8
    stacks[9] = s9

    echo(stacks)
    echo("STARTING MOVE PROCESSING")

    # now handle instructions
    breakpointhit = false
    for line in lines(inputfile):

        if line == "":
            breakpointhit = true
            continue

        if breakpointhit:
            let data = line.split(" ")
            var num_to_move = parseInt(data[1])
            let src = parseInt(data[3])
            let dst = parseInt(data[5])

            while num_to_move > 0:
                let val = stacks[src].pop()
                stacks[dst].add(val)
                num_to_move -= 1

            

    echo("stacks at end")
    echo(stacks)
    var res : string
    for i in 1 .. 9:
        res = res & stacks[i][^1]
    echo(res)

p1part1("input.txt")
