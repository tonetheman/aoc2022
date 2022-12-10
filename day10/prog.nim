
import tonyutils
import strutils

type
    CPU = object
        X : int

let data = makefilebuffer("input.txt")
echo(data)
var cpu : CPU
cpu.X = 1
var ip = 0
var cycle = 1
var total = 0

proc checksamples(cpu : CPU,cycle:int) : int =
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
        cpu.X = cpu.X + parseInt(current_instruction[1])
        total += checksamples(cpu,cycle)


    ip += 1
    if ip>len(data)-1:
        break
echo("cycle: ",cycle," ",cpu.X)
echo("total is ",total)
