@echo off
setlocal EnableDelayedExpansion

:: Set source and destination folders
set "sourceFolder=%TA_TOOLS_PATH%share\raw\maps"
set "destFolder=%~dp0"

:: Create destination folder if it doesn't exist
if not exist "%destFolder%" mkdir "%destFolder%"

:: Use forfiles to select files modified within the last day
forfiles /P "%sourceFolder%" /M *.d3dbsp /D 0 /C "cmd /c copy @path \"%destFolder%\""

endlocal
pause
