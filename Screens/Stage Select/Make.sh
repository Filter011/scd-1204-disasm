#!/bin/bash
if test -f SCDBuilt.bin; then
	mv -f SCDBuilt.bin SCDBuilt.prev.bin
fi
../../Tools/Linux-x86/asl -xx -q -A -L -U -E -i . Main.asm
../../Tools/Linux-x86/p2bin Main.p SCDBuilt.bin
rm -f Main.p