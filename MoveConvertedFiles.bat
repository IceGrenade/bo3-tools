@echo off
setlocal EnableDelayedExpansion

:: Set the root folder (parent script's directory)
set "rootFolder=%~dp0"
if "!rootFolder:~-1!"=="\" set "rootFolder=!rootFolder:~0,-1!"

:: Set the source and destination folders
set "sourceFolder=!rootFolder!\Converted Files"
set "destinationFolder=!rootFolder!"

:: Log file (same as parent script)
set "logFile=!rootFolder!\conversion_log.txt"

:: Check if source folder exists
if not exist "!sourceFolder!\" (
    echo [%date% %time%] IceGrenade_MoveConvertedFiles: Source folder '!sourceFolder!' does not exist. >> "!logFile!"
    exit /b 0
)

:: Move .xmodel_export files
set "fileCount=0"
for %%F in ("!sourceFolder!\*.xmodel_export") do (
    set /a fileCount+=1
    move "%%F" "!destinationFolder!\" >nul
    if !errorlevel! equ 0 (
        echo [%date% %time%] IceGrenade_MoveConvertedFiles: Moved %%F to !destinationFolder!. >> "!logFile!"
    ) else (
        echo [%date% %time%] IceGrenade_MoveConvertedFiles: Failed to move %%F. >> "!logFile!"
    )
)

:: Log results
if !fileCount! equ 0 (
    echo [%date% %time%] IceGrenade_MoveConvertedFiles: No .xmodel_export files found in '!sourceFolder!'. >> "!logFile!"
) else (
    echo [%date% %time%] IceGrenade_MoveConvertedFiles: Moved !fileCount! .xmodel_export files to '!destinationFolder!'. >> "!logFile!"
)

:: Always exit cleanly
endlocal
exit /b 0
