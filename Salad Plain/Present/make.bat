@echo off
cd /d %~dp0
if exist scdbuilt.bin move /y scdbuilt.bin scdbuilt.prev.bin >NUL
..\..\Tools\Windows-x86\asw -xx -q -A -L -U -E -i . R11A.asm
..\..\Tools\Windows-x86\p2bin R11A.p scdbuilt.bin
del R11A.p
pause