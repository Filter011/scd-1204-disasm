@echo off
cd /d %~dp0
if exist scdbuilt.bin move /y scdbuilt.bin scdbuilt.prev.bin >NUL
..\Tools\Windows-x86\asw -xx -q -A -L -U -E -i . IPX.asm
..\Tools\Windows-x86\p2bin IPX.p scdbuilt.bin
del IPX.p
pause