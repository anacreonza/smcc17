#!/bin/bash

# InDesign CC 2017 postinstall script
# Removes the original IC workflow plug-ins that conflict with the ones from Woodwing

APPPLUGINS="/Applications/Adobe InDesign CC 2017/Adobe InDesign CC 2017.app/Contents/MacOS/Plug-Ins"

# Delete the old IC plugins from inside the .app bundle itself
if [ -d "$APPPLUGINS" ] ; then
	echo "Found IC plugins inside app bundle, deleting..."
	rm -rf "$APPPLUGINS"/InCopyWorkflow/Assignment\ UI.InDesignPlugin/
	rm -rf "$APPPLUGINS"/InCopyWorkflow/InCopy\ Bridge.InDesignPlugin/
	rm -rf "$APPPLUGINS"/InCopyWorkflow/InCopy\ Bridge\ UI.InDesignPlugin/
	rm -rf "$APPPLUGINS"/InCopyWorkflow/InCopyImport.InDesignPlugin/
	rm -rf "$APPPLUGINS"/InCopyWorkflow/InCopyExport.InDesignPlugin/
	rm -rf "$APPPLUGINS"/InCopyWorkflow/InCopyExportUI.InDesignPlugin/
	rm -rf "$APPPLUGINS"/UI/InCopyFileActions.InDesignPlugin/
fi