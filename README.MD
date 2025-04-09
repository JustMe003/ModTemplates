Annotations for [Warzone mod development](https://www.warzone.com/wiki/Mod_Developers_Guide), using luals.
This gives you tons of warzone specific types, incuding autocomplete. You no longer need to memorize the mod API!

## How to use
The files in this repository are like a template. When you are creating a mod, just copy the files you need and leave these original files intact.
To have an easier access to this repository, you can clone the repo to your local machine.

The one exception is the [Annotations](https://github.com/JustMe003/ModTemplates/blob/main/Annotations.lua) file, this file contains all the warzone specific types. The file is rather large, and we don't need the file in every mod; It only acts as a type library, it is not needed to copy-paste the file into every new project

## How to add Annotations to your projects

In VS code:
First download [this VSCode](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) extension. 

In the settings of this extension, search for the setting `workspace: Library`. Click the `Add Item` button and fill in the path to the Annotations file on your local machine. 

If this doesn't work, you can always add the file manually:
In the folder you are working in, create a new folder with the name `.vscode` if it doesn't already exist.
In this folder, create a new file with the name `settings.json` if it doesn't already exists.
Add the following `JSON` code to the file:
```json
{
	"Lua.workspace.library": [
		"c:\\Users\\username\\Documents\\WarzoneModTemplates\\Annotations.lua"
	],
}
```
Replace the example path with the right path for your machine. You can copy-paste the `.vscode` folder from project to project if needed!

For learning more about how the annotation works, check out luals [wiki](https://luals.github.io/wiki/annotations/)



Annotations made by [Just_A_Dutchman_](https://github.com/JustMe003)

Credits to [TBestLittleHelper](https://github.com/TBestLittleHelper) for helping me out
