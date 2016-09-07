test.o: test.s
	as -g test.s -o test.o

test: test.o test.s
	ld -e _start -o test test.o

cradle: cradle.pas
	fpc cradle.pas 2>/dev/null

output.o: output.s
	as -g output.s -o output.o

output: output.o output.s
	ld -e _start -arch elf -o output output.o

clean:
	rm *.o
	rm test
	rm cradle
