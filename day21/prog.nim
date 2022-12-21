import tonyutils
import strutils
import std/tables


type
    ActionType = enum
        sAct, sInt
    Action = object
        typ : ActionType
        sact : string
        val : int
        completed : bool

proc insert_new_action(m : var Table[string,Action], input_string:string) =
    let mdata = input_string.split(":")
    # name and action for this monkey
    let mname = mdata[0]
    let mact  = mdata[1].strip()
    var mval : int = -1
    var mtyp : ActionType = sAct
    try:
        mval = parseInt(mact)
        mtyp = sInt
    except ValueError:
        discard
    m[mname] = Action(typ: mtyp, sact : mact, val: mval, completed: false)
    if mtyp == sInt:
        m[mname].completed = true

proc resolve(name : string, m : var Table[string,Action]) =
    if m[name].completed:
        return
    if m[name].typ == sInt:
        return
    let act = m[name].sact.split(" ")
    let op = act[1]
    let v1 = act[0]
    let v2 = act[2]

    if m[v1].completed and m[v2].completed:
        if op == "*":
            m[name].val = m[v1].val * m[v2].val
            m[name].completed = true
        elif op == "-":
            m[name].val = m[v1].val - m[v2].val
            m[name].completed = true
        elif op == "+":
            m[name].val = m[v1].val + m[v2].val
            m[name].completed = true
        elif op == "/":
            m[name].val = int(m[v1].val / m[v2].val)
            m[name].completed = true

proc countcompleted(m : Table[string,Action]) : int =
    var count = 0
    for sm in m.keys:
        if m[sm].completed:
            count += 1
    return count

proc part1() =
    let fdata = makefilebuffer("input.txt")
    var m : Table[string,Action]
    for s in fdata:
        insert_new_action(m, s)

    let ll = len(m)
    while m.countcompleted() < ll:

        for singlemonkey in m.keys:
            resolve(singlemonkey,m)

    echo("root is: ", m["root"])

# part1()

proc part2() =
    let fdata = makefilebuffer("sample.txt")
    var m : Table[string,Action]
    for s in fdata:
        insert_new_action(m,s)
    
    # adjust roots action

    # change humn action to a number

    # eval and look for root equality match

part2()
