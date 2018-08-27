#!/bin/bash

# Builds a packaged version of Smart Connection for InDesign drawing from the plugins currently installed.

# Global variables

APPFOLDER="/Applications/Adobe InDesign CC 2017"
PLUGIN_FOLDER="$APPFOLDER/Plug-Ins"
WW_PLUGIN_FOLDER="$APPFOLDER/Plug-Ins/WoodWing"
INSTALLED_INFO="$WW_PLUGIN_FOLDER/SCCoreInDesign.InDesignPlugin/Versions/A/Resources/Info.plist"
if [[ -f $INSTALLED_INFO ]] ; then
	INSTALLED_VER=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$INSTALLED_INFO"`
else
	echo "Smart Connection InDesign CC 2017 not installed!"
	exit 1
fi

#Build function

build () {

	if [[ ! -d "$INSTALLED_VER/scripts/" ]] ; then
		mkdir -p "$INSTALLED_VER/scripts/"
	fi
	if [[ ! -d "$INSTALLED_VER/build/" ]] ; then
		mkdir -p "$INSTALLED_VER/build/"
	fi
	if [[ ! -d "$INSTALLED_VER/payload/$PLUGIN_FOLDER/" ]] ; then
		mkdir -p "$INSTALLED_VER/payload/$PLUGIN_FOLDER/"
	fi
	# Copy plugin files into payload
	rsync -a "$WW_PLUGIN_FOLDER" "$INSTALLED_VER/payload/$PLUGIN_FOLDER"
	
	# Copy uninstaller into payload
	INSTALLED_VER_FIXED=${INSTALLED_VER//'build '/'Build'} # Parameter expansion is hard
	cp -R "$APPFOLDER/Uninstall Smart Connection for Adobe CC 2017 ${INSTALLED_VER_FIXED}.app" "$INSTALLED_VER/payload/$APPFOLDER/"
	
	# Copy pre and post install scripts into payload
	cp ./scripts/preinstall.sh "$INSTALLED_VER/scripts/preinstall"
	cp ./scripts/postinstall.sh "$INSTALLED_VER/scripts/postinstall"

	# Copy PluginConfig.txt file into payload
	cp -R "$APPFOLDER"/PluginConfig.txt "$INSTALLED_VER/payload/$APPFOLDER/"
	
	# Copy WoodWingUI ZXP folder into payload
	cp -R "$APPFOLDER/WoodWingUI ZXP" "$INSTALLED_VER/payload/$APPFOLDER/"
	
	pkgbuild --root "./$INSTALLED_VER/payload/" \
		 --identifier com.media24.woodwing.smartconnidCC17 \
		 --version "$INSTALLED_VER" \
		 --scripts "$INSTALLED_VER/scripts/" \
		 "$INSTALLED_VER/build/M24 WoodWing Smart Connection InDesign 2017 $INSTALLED_VER.pkg"
	printf "\nBuilt new package M24 Woodwing Smart Connection $INSTALLED_VER.\n\n"
}

# Check if the Woodwing plugin folder exists

if [ -z "$PLUGIN_FOLDER" ] ; then
	printf "No Smart Connection found in your InDesign CC 2017 plugins folder.\n"
	exit 0	
fi

printf "\nYou have version $INSTALLED_VER installed.\n\n"

if [ -d ./"$INSTALLED_VER" ] ; then
	printf "You already have a build for $INSTALLED_VER\n"
	printf "Rebuild package anyway? (y/n)"
	read rebuild
	if [ "$rebuild" == "y" ] ; then
		mkdir -p "$INSTALLED_VER/payload/Applications"
		build
	fi		
else
	printf "New version detected.\n"
	printf "Build new package for $INSTALLED_VER? (y/n)"
	read build
	if [ "$build" == "y" ] ; then
		mkdir -p "$INSTALLED_VER/payload/Applications"
		build
		echo "Built package for $INSTALLED_VER"
	fi		
fi

# Build uninstaller package

if [ ! -d "$INSTALLED_VER/uninstall_script/" ] ; then
	mkdir "$INSTALLED_VER/uninstall_script/"
fi

# Copy uninstaller postinstall script into uninstaller folder

cp ./scripts/uninstaller.sh "$INSTALLED_VER/uninstall_script/postinstall"

# Build uninstaller

pkgbuild  --nopayload \
		  --scripts "$INSTALLED_VER/uninstall_script/" \
		  --identifier com.media24.woodwing.smartconnidCC17 \
		  "$INSTALLED_VER/build/M24 WoodWing Smart Connection InDesign 2017 $INSTALLED_VER uninstall.pkg"

exit 0
