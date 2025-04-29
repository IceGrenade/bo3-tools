@echo off
:loop
if "%~1"=="" goto endloop
set "file=%~1"
set "newfile=%file:.map.d3dbsp=%"
powershell.exe -Command "Rename-Item -Path '%file%' -NewName '%newfile%'"
shift
goto loop
:endloop
pause
