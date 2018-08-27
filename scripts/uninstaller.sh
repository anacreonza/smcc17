#!/bin/bash

# Script to uninstall Smart Connection and to restore InDesign to pre-installation state

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

rm -rf "$WW_PLUGIN_FOLDER"
rm -rf "$APPFOLDER/WoodWingUI ZXP/"
rm "$APPFOLDER/PluginConfig.txt"
INSTALLED_VER_FIXED=${INSTALLED_VER//'build '/'Build'} # Parameter expansion is hard
rm -rf "$APPFOLDER/Uninstall Smart Connection for Adobe CC 2017 ${INSTALLED_VER_FIXED}.app"
