Annotations for [Warzone mod development](https://www.warzone.com/wiki/Mod_Developers_Guide), using luals.
This gives you tons of warzone specific types, incuding autocomplete. You no longer need to memorize the mod API!

## How to use
The files in this repository are like a template. When you are creating a mod, just copy the files you need and leave these original files intact.
One exception is the [Annotations](https://github.com/JustMe003/ModTemplates/blob/main/Annotations.lua) file, this file contains all the warzone specific types. The file is rather large, and we don't need the file in every mod; It only acts as a type library, it is not needed to copy-paste the file into every new project

## How to add Annotations to your projects

In VS code:
First download [this VSCode](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) extension. 



Add it directly to the workspace by creating a .vscode folder in the root directory. Then a settings.json file

```json
{
	"Lua.workspace.library": [
		"FILEPATH\\Annotations.lua"
	],
}
```
Remember to put you local path, not filepath. For example "C:\\WarzoneMods\\ModTemplates\\Annotations.lua"

Alternatively add it from VS code's settings UI. You are looking for Lua workspace : Libary.

For learning more about how this work, check out luals [wiki](https://luals.github.io/wiki/annotations/)



Annotations made by [Just_A_Dutchman_](https://github.com/JustMe003)

README created by [TBestLittleHelper](https://github.com/TBestLittleHelper)
