
import strutils
import std/sets

proc p1() =
    for line in lines("sample.txt"):
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
        echo()

        break

p1()