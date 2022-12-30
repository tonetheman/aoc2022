
all : prog prog2

prog2 : prog2.nim
	nim c -d:release prog2.nim

prog : prog.nim
	nim c -d:release prog.nim

clean :
	rm -f prog
	rm -f prog2
