all: test cradle

test.o: test.s
	as -g test.s -o test.o

test: test.o test.s
	ld -e _start -o test test.o

cradle: cradle.pas
	fpc cradle.pas 2>/dev/null

clean:
	rm *.o
	rm test
	rm cradle
