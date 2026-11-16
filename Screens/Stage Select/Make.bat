@echo off
cd /d %~dp0
if exist SCDBuilt.bin move /y SCDBuilt.bin SCDBuilt.prev.bin >NUL
..\..\Tools\Windows-x86\asw -xx -q -A -L -U -E -i . Main.asm
..\..\Tools\Windows-x86\p2bin Main.p SCDBuilt.bin
del Main.p
pause