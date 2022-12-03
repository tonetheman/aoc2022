
# import tables
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

proc priority(c : char ) : int =
    if c >= 'a' and c <= 'z':
        return ord(c) - ord('a') + 1
    else:
        return ord(c) - ord('A') + 1 + 26

proc p1() =
    let inf = open("input.txt")
    defer: inf.close()

    var total_priority = 0
    var line : string
    while inf.read_line(line):

        let ss : SplitString = split(line)
        # echo(ss)
        # let fCount = toCountTable(ss.f)
        # let sCount = toCountTable(ss.s)
        #for k,v in fCount.pairs:
        #    echo(k,v)
        # echo(typeof(fCount))

        let hF = toHashSet(ss.f)
        let hS = toHashSet(ss.s)

        let res = hF.intersection(hS)
        # echo(res)

        for k in res.items():
            # echo(k," ",priority(k))
            total_priority += priority(k)
        
        # echo("")
    echo("total: ",total_priority)

# testsplit()
# p1()

proc p2() =
    let inf = open("input.txt")
    defer: inf.close()

    var total_priority = 0
    var line : string
    while true:

        # weird code
        # discard is needed since I know I am reading in groups of
        # 3 lines at a time, who cares what the result of the read is?
        # live dangerously
        # this one is the only read_line that should fail        
        if not inf.read_line(line):
            break
        # weird code, normally this should be a let to me not a var
        # but if you use let it looks like nim is doing some optimization
        # and not really copying ... maybe what comes out of readline
        # is a cstring buffer? who knows
        var e1 : string = line
        discard inf.read_line(line)
        var e2 = line
        discard inf.read_line(line)
        var e3 = line

        echo(e1," ",e2," ",e3)
        
        let h1 = toHashSet(e1)
        let h2 = toHashSet(e2)
        let h3 = toHashSet(e3)

        let res = h1.intersection(h2).intersection(h3)
        echo(res)
        echo("")

        for k in res.items():
            total_priority += priority(k)

    echo("total: ",total_priority)
        


p2()