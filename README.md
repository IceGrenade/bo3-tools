I wrote these bats to help automate Zeus & EportX
https://github.com/Scobalula/Zeus & https://github.com/dtzxporter/ExportX
These are prerequisites that you have these in the same folder when running these bats.

These scripts are designed to work individually by dragging one or more file on them OR using the IceGrenade_ZeusAutomation to auto convert all files newer than a day old, automating the whole process. (You only have to press Enter whenever it prompts)

ZeusAutomation.bat - This will convert prefabs into xmodel_bin files and move them to your Zeus program folder. It will only copy files that are less than a day old.

GetD3Files.bat - This will get all d3dbsp files and copy them from your bo3 tools and move them to your Zeus program folder. It will only copy files that are less than a day old.

GetNewPrefabs.bat - Similar to GetD3Files, this will go to your bo3 tools and copy all the prefabs to your zeus program folder. It also will only copy riles that are less than a day old.

OpenFolders.bat - This will open all the relevant folders needed to manually use zeus to convert files. Not needed when using the automation bat.

ReNamer.bat - This strips ".d3dbsp" from the files, making for cleaner filenames.

MoveConvertedFiles.bat - This moves the converted .xmodel_export files (from the second time you drag them into zeus) from the Converted Files folder, into the Zeus program folder so you can work in the same folder.
