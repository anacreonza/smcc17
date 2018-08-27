# Smart Connection installer for InDesign CC 2017

Scripts to build a remotely-deployable version of the WoodWing Smart Connection plugins for Adobe InDesign CC 2017.

```update_build_id.sh``` - This script builds a new package based on the version of the Smart Connection plugins currently installed into the currently-installed InDesign version. It checks wether the current package is older than what you have installed and prompts to build a new package.

## Updates
2018-08-13

* Included WoodWingUI ZXP folder

* Included PluginConfig.txt

* Got local uninstaller app to copy across using shell parameter expansion

* Built uninstall script and included build process into the mainline script.

## To Do

* Make script capable of creating .pkg directly from .dmg from Woodwing.com.
