
import strutils
import std/sets

proc p1() =
    var fully_contained = 0

    for line in lines("input.txt"):
        let data = line.split(",")
        let d1 = data[0].split("-")
        let d2 = data[1].split("-")

        var s1 = initHashSet[int]()        
        for i in parseInt(d1[0]) .. parseInt(d1[1]):
            s1.incl(i)
        var s2 = initHashSet[int]()
        for i in parseInt(d2[0]) .. parseInt(d2[1]):
            s2.incl(i)
        
        echo(s1)
        echo(s2)
        if s1 < s2:
            echo("s1 fully contained")
            fully_contained += 1
        if s2 < s1:
            echo("s2 fully contained")
            fully_contained += 1

        echo()

    echo("full contained count: ",fully_contained)

    # 569 is not the correct answer?
    # but it is someone elses answer?
    # 569 is too low

p1()