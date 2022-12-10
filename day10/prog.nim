
import tonyutils
import strutils

type
    CPU = object
        X : int
        xa : int
        xc : int

proc setX(cpu : ptr CPU, val:int) =
    cpu.X = val
    cpu.xa = val-1
    cpu.xc = val+1

proc checksamples(cpu : CPU, cycle:int) : int =
    if cycle == 20:
        echo("c20: ",cycle*cpu.X)
        return 20 * cpu.X
    elif cycle == 60:
        echo("c60: ", cycle*cpu.X)
        return 60 * cpu.X
    elif cycle == 100:
        echo("c100: ",cycle*cpu.X)
        return 100 * cpu.X
    elif cycle == 140:
        echo("c140: ",cycle*cpu.X)
        return 140 * cpu.X
    elif cycle == 180:
        return 180 * cpu.X
    elif cycle == 220:
        return 220 * cpu.X
    
    return 0

proc part1() =
    let data = makefilebuffer("input.txt")
    echo(data)
    var cpu : CPU
    cpu.X = 1
    var ip = 0
    var cycle = 1
    var total = 0

    while true:
        let current_instruction = data[ip].split(" ")
        if current_instruction[0]=="noop":
            # nothing happens
            echo("cycle: ",cycle," ",cpu.X)
            cycle += 1
            total += checksamples(cpu,cycle)
        elif current_instruction[0].startsWith("addx"):
            echo("cycle: ",cycle," ",cpu.X)
            echo("cycle: ",cycle+1," ",cpu.X)
            cycle += 1
            total += checksamples(cpu,cycle)
            cycle += 1
            setX(addr(cpu), cpu.X + parseInt(current_instruction[1]))
            # cpu.X = cpu.X + parseInt(current_instruction[1])
            total += checksamples(cpu,cycle)


        ip += 1
        if ip>len(data)-1:
            break
    echo("cycle: ",cycle," ",cpu.X)
    echo("total is ",total)

# part1()

proc part2() =
    let data = makefilebuffer("sample2.txt")

    var cpu : CPU
    setX(addr(cpu),1)
    # cpu.X = 1 # sprite position and it is 3 wide X is middle
    var ip = 0
    var cycle = 1

    var pixel = 0 #
    # allocate the full CRT
    # prob a much better way to do this
    var crt : string = ""

    proc printcrt() =
        var crtpos = 0
        while true:
            echo(crt[crtpos ..< crtpos+40])
            crtpos += 40
            if crtpos>=len(crt):
                break

    proc setpixel() =
        echo("setpixel: ",pixel)
        if pixel == cpu.X or pixel == cpu.xa or pixel == cpu.xc:
            echo("during cycle ",cycle, "position is ",pixel)
            # crt[pixel] = '#'
            crt.add('#')
        else:
            crt.add('.')

    proc dbg() =
        echo("cycle: ", cycle)
        echo("pixel: ", pixel)
        echo("cpu: ", cpu)
        echo(crt)
        echo()

    echo("initcrt")
    # printcrt()
    echo()

    while true:
        let current_instruction = data[ip].split(" ")
        echo("Start cycle ", cycle," ",current_instruction)

        if current_instruction[0]=="noop":
            # nothing happens
            echo("noop cycle: ",cycle," ",cpu.X)
            setpixel()
            cycle += 1
            pixel += 1
            # total += checksamples(cpu,cycle)
        elif current_instruction[0].startsWith("addx"):

            # start executing addr
            setpixel()
            # bump counters
            cycle += 1
            pixel += 1
            dbg()

            # total += checksamples(cpu,cycle)
            setpixel()
            cycle += 1
            pixel += 1
            setX(addr(cpu), cpu.X + parseInt(current_instruction[1]))
            dbg()
            

        # instruction pointer only moves after
        # multiple cycles weird
        ip += 1
        # stop at the end of instructions
        if ip>len(data)-1:
            break

        # if ip>2:
        #    break

    # printcrt()
    echo(crt)

# part2()

proc part22() =
    let data = makefilebuffer("input.txt")
    var cpu : CPU
    var pixel = 0
    var cycle = 1
    var crt = ""
    var ip = 0

    proc incpixel() =
        pixel += 1
        if pixel >= 40:
            pixel = 0

    proc setpixel() :bool =
        if pixel == cpu.X or pixel == cpu.xa or pixel == cpu.xc:
            crt.add('#')
            return true
        else:
            crt.add('.')
            return false

    setX(addr(cpu),1)

    while true:
        let instruction = data[ip].split(" ")
        if instruction[0] == "noop":
            echo("Start cycle  ",cycle, "  begin executing: ", instruction)
            var res = setpixel()
            if res:
                echo("During cycle ",cycle, "crt draws in pos ",pixel)
            else:
                echo("during cycle ",cycle, "crt does NOT draw", pixel)
            echo("cur crt: ",crt)
            echo("end of cycle ",cycle)
            echo()

            cycle += 1
            incpixel()
            # pixel += 1

        elif instruction[0] == "addx":
            echo("Start cycle  ",cycle, "  begin executing: ", instruction)
            var res = setpixel()
            if res:
                echo("During cycle ",cycle, "crt draws in pos ",pixel)
            else:
                echo("during cycle ",cycle, "crt does NOT draw", pixel)
            echo("cur crt: ",crt)
            echo("end of cycle ",cycle)
            echo()

            cycle += 1
            incpixel()
            # pixel += 1

            echo("start cycle ",cycle, " still executing ",instruction)
            res = setpixel()
            if res:
                echo("During cycle ",cycle, "crt draws in pos ",pixel)
            else:
                echo("during cycle ",cycle, "crt does NOT draw", pixel)
            echo("cur crt: ",crt)

            echo("end of cycle ",cycle)
            setX(addr(cpu), cpu.X + parseInt(instruction[1]))
            echo("finished instruction ",instruction)
            echo(cpu)
            echo()

            cycle += 1
            incpixel()
            # pixel += 1


        # if ip == 20:
        #    break

        ip += 1
        if ip>=len(data):
            break
    


    proc printcrt() =
        var crtpos = 0
        while true:
            echo(crt[crtpos ..< crtpos+40])
            crtpos += 40
            if crtpos>=len(crt):
                break

    printcrt()


part22()