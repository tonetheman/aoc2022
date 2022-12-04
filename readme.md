# advent of code 2022

# day 4
This one caused me problems. I used a HashSet from nim because I found an operator `<` that would check if a set is a proper subset.

I could not get it to work.

I changed over to an OrderedSet (really not needed just easier to debug) and there is no operator `<` for an OrderedSet for some reason.

So I just used an iterator and a contains and did the check myself by counting.

The second part was extremely easy to do because I was already counting the members that were contained in the other set.

I went back after I was done and read the nim docs closer. The `<` operator is a strict and proper test which will return false when the sets are exactly equal. So a mathematical definition. I should have read it closer clearly.

So I changed the original broken code to now use `<=` and it worked as expected.

# day 3
Day of weirdness with nim.

Something is odd with `<FILE>.read_line` in nim. This kind of code ends up not doing what I expected.

I expected (per the manual) that an assignment will copy a string not copy the reference to the string. But in the code below it only copies the reference. So in the example at the end both a and b point to the same string it appears.

```nim
var line : string
inf.read_line(line)
let a = line
inf.read_line(line)
let b = line
# both a and b point to the last thing read from the file!!!
echo(a," ",b)
```
Just not at all what I expected. It is something to do with the `let` statement. This code does work as expected.

```nim
var line : string
inf.read_line(line)
var a = line
inf.read_line(line)
var b = line
# a and b are correct they have two different values
echo(a," ",b)
```
I suspect that read_line is not returning a nim string? Or it is a buffer? Maybe that is a bug in nim or an edge case. I made a directory called `weirdreadlinebehave` that also shows it in a smaller case.

The other thing I am not questioning just because I cannot seem to find it is where I am I picking up `read_line` from? It looks like it comes with nim but I am not seeing it in the manual.

I think that I am using something not documented or old?





# day 2
Nothing crazy for today either. Always hard to think ahead for part2 given you do not know how the problem will turn.

So I went overboard and made enums and made big if statements. I think I could have come up with a coding scheme that would have made things easier to add up maybe. But it would have obscured things. So I left it simple stupid.

# day 1
Nothing too hard. More or less report break logic.

Only thing interesting to me is the slice `^` operators. Much like python has. I can never remember that nim even has those but here is the link to the manual.

https://nim-lang.org/docs/tut1.html#advanced-types-slices


