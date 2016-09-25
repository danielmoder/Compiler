cradle: cradle.pas
	fpc cradle.pas 2>/dev/null

output.o: output.s
	as -ggdb output.s -o output.o

output: output.o output.s
	ld -e _start -arch elf -o output output.o

final.o: final.s
	as -ggdb final.s -o final.o

final: final.o final.s
	ld -e _start -arch elf -o final final.o

.PHONY: clean

clean:
	rm -f *.o
	rm -f output
	rm -f cradle
	rm -f final.s
	rm -f final

