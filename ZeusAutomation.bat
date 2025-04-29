@echo off
setlocal EnableDelayedExpansion
color 6
:: Set root folder (script's directory)
set "rootFolder=%~dp0"
:: Remove trailing backslash if present
if "%rootFolder:~-1%"=="\" set "rootFolder=%rootFolder:~0,-1%"

color b
:: Log file for tracking progress and errors
set "logFile=%rootFolder%\conversion_log.txt"
echo [%date% %time%] Starting conversion process > "%logFile%"
set "errorCount=0"

:: Paths to executables and batch files
set "zeusExe=%rootFolder%\Zeus.exe"
set "exportxExe=%rootFolder%\exportx.exe"
set "getPrefabsBat=%rootFolder%\GetNewPrefabs.bat"
set "getD3FilesBat=%rootFolder%\GetD3Files.bat"
set "moveConvertedBat=%rootFolder%\MoveConvertedFiles.bat"
set "renamerBat=%rootFolder%\ReNamer.bat"

color 6
:: Check if required files exist
for %%F in ("%zeusExe%" "%exportxExe%" "%getPrefabsBat%" "%getD3FilesBat%" "%moveConvertedBat%" "%renamerBat%") do (
    if not exist "%%F" (
        echo [%date% %time%] ERROR: Required file not found: %%F >> "%logFile%"
        echo ERROR: %%F not found. Aborting process. >> "%logFile%"
        set /a errorCount+=1
        goto :finalize
    )
)

:: Step 1: Run GetNewPrefabs.bat to retrieve .map files
echo [%date% %time%] Running GetNewPrefabs.bat... >> "%logFile%"
call "%getPrefabsBat%"
if errorlevel 1 (
    echo [%date% %time%] NOTE: GetNewPrefabs.bat returned errorlevel %errorlevel%, but continuing. >> "%logFile%"
)
echo [%date% %time%] Completed GetNewPrefabs.bat. >> "%logFile%"
timeout /t 2 /nobreak >nul

color 6
:: Step 2: Convert .map files to .d3dbsp using Zeus.exe
echo [%date% %time%] Converting .map files to .d3dbsp... >> "%logFile%"
set "mapCount=0"
for %%F in ("%rootFolder%\*.map") do (
    set /a mapCount+=1
    set "outputFile=%%~nF.d3dbsp"
    if not exist "%rootFolder%\!outputFile!" (
        echo [%date% %time%] Processing %%F... >> "%logFile%"
        start /wait "" "%zeusExe%" "%%F"
        if errorlevel 1 (
            echo [%date% %time%] ERROR: Failed to convert %%F to .d3dbsp. >> "%logFile%"
            set /a errorCount+=1
        ) else (
            echo [%date% %time%] Converted %%F to !outputFile!. >> "%logFile%"
        )
    ) else (
        echo [%date% %time%] Skipping %%F: !outputFile! already exists. >> "%logFile%"
    )
    timeout /t 1 /nobreak >nul
)
if !mapCount! equ 0 (
    echo [%date% %time%] WARNING: No .map files found in %rootFolder%. >> "%logFile%"
)

:: Step 3: Run GetD3Files.bat to retrieve .d3dbsp files
echo [%date% %time%] Running GetD3Files.bat... >> "%logFile%"
call "%getD3FilesBat%"
if errorlevel 1 (
    echo [%date% %time%] NOTE: GetD3Files.bat returned errorlevel %errorlevel%, but continuing. >> "%logFile%"
)
echo [%date% %time%] Completed GetD3Files.bat. >> "%logFile%"
timeout /t 2 /nobreak >nul

color b
:: Step 4: Convert .d3dbsp files to .xmodel_export using Zeus.exe
echo [%date% %time%] Converting .d3dbsp files to .xmodel_export... >> "%logFile%"
set "d3dbspCount=0"
for %%F in ("%rootFolder%\*.d3dbsp") do (
    set /a d3dbspCount+=1
    set "outputFile=%%~nF.xmodel_export"
    if not exist "%rootFolder%\!outputFile!" (
        echo [%date% %time%] Processing %%F... >> "%logFile%"
        start /wait "" "%zeusExe%" "%%F"
        if errorlevel 1 (
            echo [%date% %time%] ERROR: Failed to convert %%F to .xmodel_export. >> "%logFile%"
            set /a errorCount+=1
        ) else (
            echo [%date% %time%] Converted %%F to !outputFile!. >> "%logFile%"
        )
    ) else (
        echo [%date% %time%] Skipping %%F: !outputFile! already exists. >> "%logFile%"
    )
    timeout /t 1 /nobreak >nul
)
if !d3dbspCount! equ 0 (
    echo [%date% %time%] WARNING: No .d3dbsp files found in %rootFolder%. >> "%logFile%"
)

:: Step 5: Run MoveConvertedFiles.bat to move .xmodel_export files
echo [%date% %time%] Running MoveConvertedFiles.bat... >> "%logFile%"
call "%moveConvertedBat%"
set "moveErrorLevel=%errorlevel%"
echo [%date% %time%] MoveConvertedFiles.bat completed with exit code !moveErrorLevel!. >> "%logFile%"
:: Check .xmodel_export files in root folder
set "xmodelCount=0"
for %%F in ("%rootFolder%\*.xmodel_export") do set /a xmodelCount+=1
if !xmodelCount! gtr 0 (
    echo [%date% %time%] Found !xmodelCount! .xmodel_export files in root folder. >> "%logFile%"
) else (
    echo [%date% %time%] WARNING: No .xmodel_export files found in root folder. >> "%logFile%"
)
echo [%date% %time%] Proceeding to step 6... >> "%logFile%"
timeout /t 2 /nobreak >nul

:: Step 6: Convert .xmodel_export files to .xmodel_bin using exportx.exe
echo [%date% %time%] Converting .xmodel_export files to .xmodel_bin... >> "%logFile%"
set "xmodelExportCount=0"
for %%F in ("%rootFolder%\*.xmodel_export") do (
    set /a xmodelExportCount+=1
    set "outputFile=%%~nF.xmodel_bin"
    if not exist "%rootFolder%\!outputFile!" (
        echo [%date% %time%] Processing %%F... >> "%logFile%"
        start /wait "" "%exportxExe%" "%%F"
        if errorlevel 1 (
            echo [%date% %time%] ERROR: Failed to convert %%F to .xmodel_bin. >> "%logFile%"
            set /a errorCount+=1
        ) else (
            echo [%date% %time%] Converted %%F to !outputFile!. >> "%logFile%"
        )
    ) else (
        echo [%date% %time%] Skipping %%F: !outputFile! already exists. >> "%logFile%"
    )
    timeout /t 1 /nobreak >nul
)
if !xmodelExportCount! equ 0 (
    echo [%date% %time%] WARNING: No .xmodel_export files found in %rootFolder%. >> "%logFile%"
)

color 6
:: Step 7: Rename .xmodel_bin files using ReNamer.bat
echo [%date% %time%] Renaming .xmodel_bin files... >> "%logFile%"
set "xmodelBinCount=0"
for %%F in ("%rootFolder%\*.xmodel_bin") do (
    set /a xmodelBinCount+=1
    echo [%date% %time%] Renaming %%F... >> "%logFile%"
    call "%renamerBat%" "%%F"
    if errorlevel 1 (
        echo [%date% %time%] ERROR: Failed to rename %%F. >> "%logFile%"
        set /a errorCount+=1
    ) else (
        echo [%date% %time%] Renamed %%F. >> "%logFile%"
    )
    timeout /t 1 /nobreak >nul
)
if !xmodelBinCount! equ 0 (
    echo [%date% %time%] WARNING: No .xmodel_bin files found in %rootFolder%. >> "%logFile%"
)

color b
:finalize
:: Final status summary
echo. >> "%logFile%"
if !errorCount! equ 0 (
    echo [%date% %time%] Conversion process completed successfully. >> "%logFile%"
) else (
    echo [%date% %time%] Conversion process completed with !errorCount! errors. Check log for details. >> "%logFile%"
)
endlocal
