# Zeus & ExportX Batch Automation Scripts

I wrote these batch files to help automate workflows using:
- [Zeus](https://github.com/Scobalula/Zeus)
- [ExportX](https://github.com/dtzxporter/ExportX)

## 📦 Prerequisites

- Place **Zeus**, **ExportX**, and these batch files in the **same folder**.
- These scripts can be used:
  - Individually — drag and drop one or more files onto the `.bat` scripts.
  - Or fully automated — use `IceGrenade_ZeusAutomation.bat` to auto-convert all files newer than a day old (you'll just need to press Enter when prompted).

---

## 🤖 Automation Script Description

### `ZeusAutomation.bat`
- Converts prefabs into `.xmodel_bin` files.
- Moves them to your Zeus program folder.
- Only processes files that are **less than a day old**.
- Automates the full conversion pipeline.

---
## 🔨 Manual Script Descriptions

### `GetD3Files.bat`
- Copies all `.d3dbsp` files from your BO3 tools folder.
- Moves them to your Zeus program folder.
- Only includes files **less than a day old**.

### `GetNewPrefabs.bat`
- Copies all prefab files from your BO3 tools folder to your Zeus folder.
- Only includes files **less than a day old**.
- Similar to `GetD3Files.bat`.

### `OpenFolders.bat`
- Opens all relevant folders needed for manual Zeus usage.
- **Not needed** if you're using the automation script.

### `ReNamer.bat`
- Removes the `.d3dbsp` extension from file names for cleaner output.

### `MoveConvertedFiles.bat`
- Moves `.xmodel_export` files (after second Zeus drag) from the `Converted Files` folder into the Zeus folder.
- Keeps everything in one working directory.

---

## 💡 Notes

- Use `ZeusAutomation.bat` for full automation.
- Designed to simplify modding workflows with Zeus & ExportX.
- Helps keep file handling clean and minimal.

## 📝 Updates

- At somepoint I want to add an exclusion list, so it can exclude big map prefabs.

