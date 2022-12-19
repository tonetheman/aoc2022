
type
    Blueprint = object
        # num ore collectors
        ore_robots : int
        # amount of ore per min
        ore_per_m : int
        # total amount of ore
        ore : int
        ore_robot_cost : int

        # num of clay robots
        clay_robots : int
        clay : int
        clay_per_m : int
        clay_robot_cost : int

        #ob
        ob_robots : int
        ob : int
        ob_per_m : int
        ob_robot_cost_clay : int
        ob_robot_cost_ore : int

proc step(m:int, bp : var Blueprint) =
    echo("step start: ",m)

    var new_clay_robot = false
    if bp.ore >= bp.clay_robot_cost:
        # get a new clay robot
        bp.ore -= bp.clay_robot_cost
        new_clay_robot = true

    # ore collectors
    if bp.ore_robots>0:
        let new_ore = bp.ore_per_m * bp.ore_robots
        bp.ore += new_ore

    if bp.clay_robots>0:
        let new_clay = bp.clay_per_m * bp.clay_robots
        bp.clay += new_clay

    # at the end add new bots here
    if new_clay_robot:
        bp.clay_robots += 1


var bp : Blueprint = Blueprint(ore_robots:1,
    ore_per_m:1, ore:0, ore_robot_cost:4,
    clay_robots:0, clay:0,clay_per_m:1,clay_robot_cost:2,
    ob:0,ob_robots:0,ob_per_m:1,
        ob_robot_cost_ore:2,ob_robot_cost_clay:14)
    
var minute = 1
while true:
    step(minute,bp)
    echo("after step  : ", minute)
    echo("ore avail   : ", bp.ore)
    echo("clay avail  : ", bp.clay )
    echo("ob avail    : ", bp.ob)
    echo("# ore bots  : ", bp.ore_robots)
    echo("# clay bots : ", bp.clay_robots)
    echo("# ob bots   : ", bp.ob_robots)
    echo()
    minute += 1
    if minute > 6:
        break
