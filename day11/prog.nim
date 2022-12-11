
import tonyutils
import sequtils
import strutils

proc parse_id(s:string) : int =
    var mdata = s.split(" ")
    if mdata[0] == "Monkey":
        result = parseInt(mdata[1][0 .. ^2])
    return result

proc parse_items(s:string) : seq[int] =
    var sdata = s.split(":")
    var idata = sdata[1].strip().split(",")
    for s in idata:
        result.add(parseInt(s.strip()))

proc parse_op(s:string) : seq[string] =
    var x =  (s.split(":")[1].strip()).split()
    for i in 2 .. len(x)-1:
        result.add(x[i])

proc parse_test(s:string) : string =
    discard

proc p1old() =
    let fdata = makefilebuffer("sample.txt")
    var index = 0

    # parse monkey line
    var monkeyid = parse_id(fdata[index])
    index += 1

    # parse starting items
    var items = parse_items(fdata[index])
    index += 1

    var op = parse_op(fdata[index])
    index += 1

    var tst = parse_test(fdata[index])
    index += 1

    echo("current monkey: ",monkeyid)
    echo("items:",items)
    echo("op: ",op)
# p1()

type
    Monkey = object
        id : int
        items : seq[int]
        op : proc(i:int) : int
        tst : proc(i:int) : bool
        tval : int
        fval : int
        icount : int
        post: proc(i:int):int


proc turn(allMonkeys: var seq[Monkey], m: var Monkey) =
    var count = 0
    echo("monkey ",m.id)
    for i in m.items:
        count += 1
        echo("\t\tworry level: ", i)
        m.icount += 1
        var new_worry = m.op(i)
        echo("\t\tnew worry level: ", new_worry)
        new_worry = new_worry div 3
        echo("\t\tbored monkey: ", new_worry)
        let res = m.tst(new_worry)
        echo("\t\tres: ",res)
        if res:
            echo("\t\tthrow to ", m.tval)
            allMonkeys[m.tval].items.add(new_worry)
        else:
            echo("\t\tthrow to ",m.fval)
            allMonkeys[m.fval].items.add(new_worry)
        echo("")
    
    for i in 0 .. count-1:
        sequtils.delete(m.items, 0, 0)
        echo("\tdelete")

proc round(allMonkeys : var seq[Monkey]) =
    for m in allMonkeys.mitems:
        turn(allMonkeys, m)

proc p1(allMonkeys: var seq[Monkey]) = 
    for i in 0 ..< 20:
        round(allMonkeys)
    for m in allMonkeys:
        echo("Monkey ",m.id,": ",m.items)
        echo("\ticount: ",m.icount)

proc sample_monkeys() : seq[Monkey] =
    proc m0_op(i:int):int = i*19
    proc m1_op(i:int):int = i+6
    proc m2_op(i:int):int = i*i
    proc m3_op(i:int):int = i+3
    proc t0(i:int):bool = i mod 23 == 0
    proc t1(i:int):bool = i mod 19 == 0
    proc t2(i:int):bool = i mod 13 == 0
    proc t3(i:int):bool = i mod 17 == 0

    var allMonkeys : seq[Monkey] = newSeq[Monkey]()
    allMonkeys.add(Monkey(id:0, items: @[79,98],op:m0_op,tst:t0,tval:2,fval:3))
    allMonkeys.add(Monkey(id:1, items: @[54,65,75,74],op:m1_op,tst:t1,tval:2,fval:0))
    allMonkeys.add(Monkey(id:2, items: @[79,60,97],op:m2_op,tst:t2,tval:1,fval:3))
    allMonkeys.add(Monkey(id:3, items: @[74],op:m3_op,tst:t3,tval:0,fval:1))

    return allMonkeys

proc input_monkeys() : seq[Monkey] =
    proc m0_op(i:int):int = i*3
    proc t0(i:int):bool = i mod 2 == 0
    proc m1_op(i:int):int = i * 19
    proc t1(i:int):bool = i mod 7 == 0
    proc m2_op(i:int):int = i+2
    proc t2(i:int):bool = i mod 11 == 0
    proc m3(i:int):int = i*i
    proc t3(i:int):bool = i mod 19 == 0
    proc m4(i:int):int = i+8
    proc t4(i:int):bool = i mod 3 == 0
    proc m5(i:int):int = i+6
    proc t5(i:int):bool = i mod 5 == 0
    proc m6(i:int):int = i+7
    proc t6(i:int):bool = i mod 17 == 0
    proc m7(i:int):int = i+4
    proc t7(i:int):bool = i mod 13 == 0

    var allMonkeys : seq[Monkey] = newSeq[Monkey]()
    allMonkeys.add(Monkey(id:0,items: @[66, 59, 64, 51],op:m0_op,tst:t0,tval:1,fval:4))
    allMonkeys.add(Monkey(id:1,items: @[67, 61],op:m1_op,tst:t1,tval:3,fval:5))
    allMonkeys.add(Monkey(id:2,items: @[86, 93, 80, 70, 71, 81, 56],op:m2_op,tst:t2,tval:4,fval:0))
    allMonkeys.add(Monkey(id:3,items: @[94],op:m3,tst:t3,tval:7,fval:6))
    allMonkeys.add(Monkey(id:4,items: @[71, 92, 64],op:m4,tst:t4,tval:5,fval:1))
    allMonkeys.add(Monkey(id:5,items: @[58, 81, 92, 75, 56],op:m5,tst:t5,tval:3,fval:6))
    allMonkeys.add(Monkey(id:6,items: @[82, 98, 77, 94, 86, 81],op:m6,tst:t6,tval:7,fval:2))
    allMonkeys.add(Monkey(id:7,items: @[54, 95, 70, 93, 88, 93, 63, 50],op:m7,tst:t7,tval:2,fval:0))
    return allMonkeys

# var s = sample_monkeys()
# p1(s)
# var s = input_monkeys()
# p1(s)

# [GCC 9.4.0] on linux
# Type "help", "copyright", "credits" or "license" for more information.
# >>> 303*298
# 90294

proc turn_part2(allMonkeys: var seq[Monkey], m: var Monkey) =
    var count = len(m.items)-1

    for i in m.items:
        m.icount += 1
        var new_worry = m.op(i)
        # new_worry = new_worry div 3
        let res = m.tst(new_worry)
        if res:
            allMonkeys[m.tval].items.add(new_worry)
        else:
            allMonkeys[m.fval].items.add(new_worry)
    
    for i in 0 .. count:
        sequtils.delete(m.items, 0, 0)

proc round_part2(allMonkeys : var seq[Monkey]) =
    for m in allMonkeys.mitems:
        turn_part2(allMonkeys, m)

proc p2(allMonkeys: var seq[Monkey]) = 
    for i in 0 ..< 20:
        round_part2(allMonkeys)
    for m in allMonkeys:
        echo("Monkey ",m.id,": ",m.items)
        echo("\ticount: ",m.icount)

# not sure why this would not work
# i should be able to go ahead and take the mod
# as part of the operation to reduce the number
# of bits needed
proc sample_monkeys_part2() : seq[Monkey] =
    proc m0_op(i:int):int = i*19 
    proc m1_op(i:int):int = i+6
    proc m2_op(i:int):int = i*i
    proc m3_op(i:int):int = i+3
    proc t0(i:int):bool = i mod 23 == 0
    proc t1(i:int):bool = i mod 19 == 0
    proc t2(i:int):bool = i mod 13 == 0
    proc t3(i:int):bool = i mod 17 == 0
    proc p0(i:int):int = i mod 23
    proc p1(i:int):int = i mod 19
    proc p2(i:int):int = i mod 13
    proc p3(i:int):int = i mod 17

    var allMonkeys : seq[Monkey] = newSeq[Monkey]()
    allMonkeys.add(Monkey(id:0, items: @[79,98],op:m0_op,tst:t0,tval:2,fval:3,post:p0))
    allMonkeys.add(Monkey(id:1, items: @[54,65,75,74],op:m1_op,tst:t1,tval:2,fval:0,post:p1))
    allMonkeys.add(Monkey(id:2, items: @[79,60,97],op:m2_op,tst:t2,tval:1,fval:3,post:p2))
    allMonkeys.add(Monkey(id:3, items: @[74],op:m3_op,tst:t3,tval:0,fval:1,post:p3))

    return allMonkeys

var s = sample_monkeys_part2()
p2(s)
