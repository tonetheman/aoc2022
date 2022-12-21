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
        op : string
        v1 : string
        v2 : string

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
    if mtyp == sAct:
        let act = m[mname].sact.split(" ")
        m[mname].op = act[1]
        m[mname].v1 = act[0]
        m[mname].v2 = act[2]


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

proc resolve2(name : string, m : var Table[string,Action]) : int =
    if m[name].completed:
        return 0
    if m[name].typ == sInt:
        return 0
    
    let op = m[name].op
    let v1 = m[name].v1
    let v2 = m[name].v2

    if name == "root":
        if m[v1].completed and m[v2].completed:
            if m[v1].val == m[v2].val:
                m["root"].completed = true
        return 100

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
    return 0

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

proc reset_completed(m : var Table[string,Action]) =
    for name in m.keys:
        if m[name].typ == sInt:
            m[name].completed = true
        else:
            m[name].completed = false

proc part2() =
    let fdata = makefilebuffer("sample.txt")
    var m : Table[string,Action]
    for s in fdata:
        insert_new_action(m,s)
    
    # adjust roots action
    let ll = len(m)

    # change humn action to a number
    for i in 0 ..< 3:
        # echo("starting humn is: ", m["humn"])
        m.reset_completed()
        m["humn"].val = i

        # eval and look for root equality match
        block outer:
            while m.countcompleted() < ll-1:

                for singlemonkey in m.keys:
                    let res = resolve2(singlemonkey,m)
                    # 100 is a signal from root
                    # that it did resolve true
                    # which could happen early?
                    if res == 100:
                        echo("breaking to outer")
                        break outer
                    

        # echo("root completion: ",m["root"].completed)
        let res = resolve2("root",m)
        if res == 100:
            echo("done?",i)
        # echo("root completion: ",m["root"].completed)
        if m["root"].completed == true:
            echo("i is ",i)
            break
        else:
            discard """
            if i mod 100 == 0:
                system.stdout.write("*")
                flushFile(stdout)
                """
            

part2()
