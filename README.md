I wrote these bats to help automate Zeus (https://github.com/Scobalula/Zeus)

These scripts are designed to work individually by dragging one or more file on them
OR use the IceGrenade_ZeusAutomation to auto convert all files newer than a day old, automating the whole process

IceGrenade_GetD3Files
	This will get all d3dbsp files and copy them from your bo3 tools and move them to your Zeus program folder. It will only copy files that are less than a day old.

IceGrenade_GetNewPrefabs.bat
	Similar to GetD3Files, this will go to your bo3 tools and copy all the prefabs to your zeus program folder. It also will only copy riles that are less than a day old.

IceGrenade_OpenFolders.bat
	This will open all the relevant folders needed to manually use zeus to convert files. Not needed when using the automation bat.

IceGrenade_ReNamer.bat
	This strips ".d3dbsp" from the files, making for cleaner filenames.

IceGrenade_MoveConvertedFiles.bat
	This moves the converted .xmodel_export files (from the second time you drag them into zeus) from the Converted Files folder, into the Zeus program folder so you can work in the same folder.
