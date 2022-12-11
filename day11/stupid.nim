

import bigints
import sequtils

type
    Monkey = object
        id : int
        items : seq[BigInt]
        op : proc(i:BigInt) : BigInt
        tst : proc(i:BigInt) : bool
        tval : int
        fval : int
        icount : int
        post: proc(i:int):int

proc sample_monkeys() : seq[Monkey] =
    proc m0_op(i:BigInt):BigInt = i * 19'bi
    proc m1_op(i:BigInt):BigInt = i + 6'bi
    proc m2_op(i:BigInt):BigInt = i*i
    proc m3_op(i:BigInt):BigInt = i+ 3'bi
    proc t0(i:BigInt):bool = i mod 23'bi == 0'bi
    proc t1(i:BigInt):bool = i mod 19'bi == 0'bi
    proc t2(i:BigInt):bool = i mod 13'bi == 0'bi
    proc t3(i:BigInt):bool = i mod 17'bi == 0'bi

    var allMonkeys : seq[Monkey] = newSeq[Monkey]()
    allMonkeys.add(Monkey(id:0, items: @[ 79'bi, 98'bi],op:m0_op,tst:t0,tval:2,fval:3))
    allMonkeys.add(Monkey(id:1, items: @[ 54'bi ,65'bi ,75'bi ,74'bi ],op:m1_op,tst:t1,tval:2,fval:0))
    allMonkeys.add(Monkey(id:2, items: @[ 79'bi, 60'bi, 97'bi ],op:m2_op,tst:t2,tval:1,fval:3))
    allMonkeys.add(Monkey(id:3, items: @ [ 74'bi ],op:m3_op,tst:t3,tval:0,fval:1))

    return allMonkeys

proc turn(allMonkeys: var seq[Monkey], m: var Monkey) =
    var count = 0
    for i in m.items:
        count += 1
        m.icount += 1
        var new_worry = m.op(i)
        let res = m.tst(new_worry)
        if res:
            allMonkeys[m.tval].items.add(new_worry)
        else:
            allMonkeys[m.fval].items.add(new_worry)
    
    for i in 0 .. count-1:
        sequtils.delete(m.items, 0, 0)

proc round(allMonkeys : var seq[Monkey]) =
    for m in allMonkeys.mitems:
        turn(allMonkeys, m)

proc p1(allMonkeys: var seq[Monkey]) = 
    for i in 0 ..< 1000:
        if i mod 10==0: echo(i,"working...")
        round(allMonkeys)
    for m in allMonkeys:
        echo("Monkey ",m.id,": ",m.items)
        echo("\ticount: ",m.icount)

var allMonkeys = sample_monkeys()
p1(allMonkeys)