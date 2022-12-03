
import tables
import sets

type
    SplitString = tuple
        f : string
        s : string

proc split(s:string) : SplitString =
    let ll = len(s)
    let half = (int)ll/2
    let first = s[0 .. half-1 ]
    let second  = s[ half .. ll-1]
    return (first,second)

proc testsplit() =
    proc testme(s:string) = 
        let ss = split(s)
        assert(ss.f == "vJrwpWtwJgWr")
        assert(ss.s == "hcsFMMfFFhFp")
    proc testme2(s:string) = 
        let ss = split(s)
        assert(ss.f == "jqHRNqRjqzjGDLGL")
        assert(ss.s == "rsFMfFZSrLrFZsSL")
    proc testme3(s:string) = 
        let ss = split(s)
        assert(ss.f == "PmmdzqPrV")
        assert(ss.s == "vPwwTWBwg")
    
    let s = "vJrwpWtwJgWrhcsFMMfFFhFp"
    testme(s)
    testme2("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL")
    testme3("PmmdzqPrVvPwwTWBwg")

proc p1() =
    let inf = open("sample.txt")
    defer: inf.close()

    var line : string
    while inf.read_line(line):

        let ss : SplitString = split(line)
        echo(ss)
        let fCount = toCountTable(ss.f)
        let sCount = toCountTable(ss.s)
        #for k,v in fCount.pairs:
        #    echo(k,v)
        # echo(typeof(fCount))

        let hF = toHashSet(ss.f)
        let hS = toHashSet(ss.s)

        echo(hF.intersection(hS))


        
        echo("")

testsplit()
p1()