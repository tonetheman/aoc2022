# advent of code 2022

# day 12
FFS nim does some stuff great but documentation on fairly standard things like multi-dimensional arrays or sequences... well good luck here is google.

I found an example on rosettacode that shows how to do a multi dimensional sequence. It is fairly similar to Java and other languages I have used.

https://rosettacode.org/wiki/Create_a_two-dimensional_array_at_runtime#Nim




# day 11
Oh to be in a scripting language. Mostly hard coded everything but I started to parse it and thought there were not that many monkeys.

But part2 is not possible to solve with an int it appears. I am sure there is a trick of some sort but I have not cheated yet to see what that is. It has something to do with the numbers in the test all being prime.

So I got part1 and I will have to punt on part2 for a while. I will end up having to cheat and see how other people solved it.

Python with its magicially large integers or lisp you would not need to worry about overflow. In that regard nim sucks. But I still like the static type and speed. Just for problems with large numbers it is not great vs a language like Python.

edit: Tried some things like using mod to reduce the numbers down. Which did not work for some reason?
Also tried a bignumber library this also did not work because of speed around 600 iterations it starts getting progressively slower and slower.

edit2: Found a random comment on reddit and tried it. at least I am not the only person who is having trouble. it works for the sample but not for the input. sigh. And I have no clue why it works at all much less not works on the input.

# day 10
Took me a while because I never reset the damn pixel position.

# day 9
so insane I could not even do anything with it.

# day 8
Tree heights. Nothing super tricky other than me not reading the problems super close.

I think my solution is not optimized in any way though. I am certain I could have done it differently.

I learned how to make a 2d array in nim
```nim
var a : seq[ seq[int] ] = newSeq[newSeq[int](cols)](rows)
```
I also reused my file reading from the previous day. I need to read how to handle modules instead of copy pasting it.

# day 7
Wow I do not like trees.

Also learned about how pointers work (sort of) in nim. I found this GREAT reference:

https://ssalewski.de/nimprogramming.html#_value_objects_and_references

Most of the work was building a tree for the input. I am certain there are better ways to do it than what I ended up with.

# day 6
All about a protocol. Lots of hard codes in this. When you know where to start the problem is much easier.

The first part of the problem I hard coded even the checking. But if I was writing a protocol checker IRL I would have done something similar for the first version.

I stole my file reading routine from the previous day. So I reused code. Yay.

The second part I felt was different enough version of the protocol that I changed my pattern for file names.
Also the protocol changed enough that I had to remove some of the hard coding and let the compiler do the work on the check. So the checking code is better in part2 than part1.

# day 5
Stacks. I do love stacks. Nim has calls that will let you simulate a stack. The `add` and `pop` calls on `seq[T]` work great for this.

And AOC is fairly controlled so I did not do any type of bounds/error checking on the stack operations. I figured if I got an error or a bounds issue I was doing something wrong. In real life it would be more robust.

The parsing today was gross. I decided that blank line was my real key and used that to handle parsing the package setup vs the movement data.

I did not try to be fancy so everything is hardcoded AF.

And improvement would be to remove that hard coding.

edit: later I went back and made `progfun.nim` that does a much better handling of the input files. Nothing is hard coded in terms of the number of stacks. I still hard coded some of the positions of the data but it is effectively column based so that should be fine.

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


