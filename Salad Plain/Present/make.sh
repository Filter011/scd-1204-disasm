#!/bin/bash
if test -f scdbuilt.bin; then
	mv -f scdbuilt.bin scdbuilt.prev.bin
fi
../../Tools/Linux-x86/asl -xx -q -A -L -U -E -i . R11A.asm
../../Tools/Linux-x86/p2bin R11A.p scdbuilt.bin
rm -f R11A.p