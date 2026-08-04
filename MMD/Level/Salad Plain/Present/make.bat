@echo off
if exist scdbuilt.bin move /y scdbuilt.bin scdbuilt.prev.bin >NUL
..\..\..\..\Tools\asw -xx -q -A -L -U -E -i . R11A.asm
..\..\..\..\Tools\p2bin R11A.p scdbuilt.bin
del R11A.p
pause