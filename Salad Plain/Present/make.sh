#!/bin/bash
if test -f scdbuilt.bin; then
	mv -f scdbuilt.bin scdbuilt.prev.bin
fi
../../Tools/Linux-x86/asl -xx -q -A -L -U -E -i . main.asm
../../Tools/Linux-x86/p2bin main.p scdbuilt.bin
rm -f main.p