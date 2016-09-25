#!/bin/bash
read var
echo $var > input.txt

(./cradle < input.txt) > cradleout.s

cat x86Start.s > final.s
cat cradleout.s >> final.s
cat x86End.s >> final.s

`make final.o`
`make final`

rm input.txt
rm cradleout.s
