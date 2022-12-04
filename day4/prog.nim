
import strutils
import std/sets

# ha this does not work
# but i am not sure why exactly
proc p1doesnotwork() =
    var fully_contained = 0

    var id = 0

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
        
        if s1 < s2:
            fully_contained += 1
            echo("id: ",id, " s1<s2")
            id += 1
            continue

        if s2 < s1:
            fully_contained += 1
            echo("id: ",id, " s2<s1")
            id += 1
            continue

        
    echo("full contained count: ",fully_contained)

    # 569 is not the correct answer?
    # but it is someone elses answer?
    # 569 is too low

proc p1() =
    var fully_contained = 0
    var id = 0

    for line in lines("input.txt"):
        let data = line.split(",")
        let d1 = data[0].split("-")
        let d2 = data[1].split("-")

        var s1 = initOrderedSet[int]()        
        for i in parseInt(d1[0]) .. parseInt(d1[1]):
            s1.incl(i)
        var s2 = initOrderedSet[int]()
        for i in parseInt(d2[0]) .. parseInt(d2[1]):
            s2.incl(i)
        
        # is every member of s1 in s2
        var count = 0
        for s in s1:
            if s2.contains(s):
                count += 1
        if count == len(s1):
            fully_contained += 1
            echo("id: ",id, " s1 in s2")
            id += 1
            continue
        
        # is every member of s2 in s1
        count = 0
        for s in s2:
            if s1.contains(s):
                count += 1
        if count == len(s2):
            fully_contained += 1
            echo("id: ",id, " s2 in s1")
            id += 1
            continue

        #if s1 < s2:
        #    echo("s1 fully contained")
        #    fully_contained += 1
        #if s2 < s1:
        #    echo("s2 fully contained")
        #    fully_contained += 1

        
    #
    # damn it 607 is too high?

    echo("full contained count: ",fully_contained)

#p1doesnotwork()
# p1()

proc p2() =
    var fully_contained = 0
    var id = 0

    for line in lines("input.txt"):
        let data = line.split(",")
        let d1 = data[0].split("-")
        let d2 = data[1].split("-")

        var s1 = initOrderedSet[int]()        
        for i in parseInt(d1[0]) .. parseInt(d1[1]):
            s1.incl(i)
        var s2 = initOrderedSet[int]()
        for i in parseInt(d2[0]) .. parseInt(d2[1]):
            s2.incl(i)
        
        # is every member of s1 in s2
        var count = 0
        for s in s1:
            if s2.contains(s):
                count += 1
        if count > 0:
        # if count == len(s1):
            fully_contained += 1
            echo("id: ",id, " s1 in s2")
            id += 1
            continue
        
        # is every member of s2 in s1
        count = 0
        for s in s2:
            if s1.contains(s):
                count += 1
        if count > 0:
        # if count == len(s2):
            fully_contained += 1
            echo("id: ",id, " s2 in s1")
            id += 1
            continue


    echo("contained count: ",fully_contained)

p2()