@echo off
cd /d %~dp0
if exist scdbuilt.bin move /y scdbuilt.bin scdbuilt.prev.bin >NUL
..\..\Tools\Windows-x86\asw -xx -q -A -L -U -E -i . main.asm
..\..\Tools\Windows-x86\p2bin main.p scdbuilt.bin
del main.p
pause