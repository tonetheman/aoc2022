
import strutils

type
    weapon = enum
        wUnknown, wRock, wPaper, wScissors
    results = enum
        rUnknown, rWin, rLoss, rDraw
    shouldResults = enum
        rShouldLost, rShouldWin, rShouldDraw

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

# p1()


proc p2() =
    let inf = open("input.txt")
    defer: inf.close()

    var total_score = 0

    var line : string
    while inf.read_line(line):
        let data = line.split(" ")
        var player : weapon = wUnknown
        var opp : weapon = wUnknown
        var should : shouldResults

        if data[0] == "A":
            opp = wRock
        elif data[0] == "B":
            opp = wPaper
        elif data[0] == "C":
            opp = wScissors

        if data[1] == "X":
            should = rShouldLost
        elif data[1] == "Y":
            should = rShouldDraw
        elif data[1] == "Z":
            should = rShouldWin
        
        if should == rShouldWin:
            if opp == wRock:
                player = wPaper
            elif opp == wScissors:
                player = wRock
            elif opp == wPaper:
                player = wScissors
        elif should == rShouldLost:
            if opp == wRock:
                player = wScissors
            elif opp == wScissors:
                player = wPaper
            elif opp == wPaper:
                player = wRock
        elif should == rShouldDraw:
            player = opp

        # will need this code to score
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

p2()