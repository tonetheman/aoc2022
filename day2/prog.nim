
import strutils

type
    weapon = enum
        wUnknown, wRock, wPaper, wScissors
    results = enum
        rUnknown, rWin, rLoss, rDraw

proc t(i:weapon) : string =
    if i==wRock:
        return "rock"
    elif i==wPaper:
        return "paper"
    elif i==wScissors:
        return "scissors"
    else:
        return "other"

proc p1() =
    let inf = open("input.txt")
    defer: inf.close()

    var total_score = 0

    var line : string
    while inf.read_line(line):
        let data = line.split(" ")
        var player : weapon = wUnknown
        var opp : weapon = wUnknown

        if data[0] == "A":
            opp = wRock
        elif data[0] == "B":
            opp = wPaper
        elif data[0] == "C":
            opp = wScissors

        if data[1] == "X":
            player = wRock
        elif data[1] == "Y":
            player = wPaper
        elif data[1] == "Z":
            player = wScissors
        
        var win : results = rUnknown

        if player == wRock and opp == wScissors:
            win = rWin
        elif player == wScissors and opp == wPaper:
            win = rWin
        elif player == wPaper and opp == wRock:
            win = rWin
        elif opp == wRock and player == wScissors:
            win = rLoss
        elif opp == wScissors and player == wPaper:
            win = rLoss
        elif opp == wPaper and player == wRock:
            win = rLoss
        else:
            win = rDraw

        var score = 0
        if player == wRock:
            score = 1
        elif player == wPaper:
            score = 2
        elif player == wScissors:
            score = 3
        else:
            score = -1
        
        if win == rWin:
            score += 6
        elif win == rLoss:
            score += 0
        elif win == rDraw:
            score += 3

        echo(player," ",opp," ",win," score: ",score)

        total_score += score
    
    echo("total score for round: ", total_score)

p1()