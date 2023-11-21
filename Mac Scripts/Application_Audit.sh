#!/bin/bash

#############################################################################################
# Created by Michael LeMay
#############################################################################################
# How to find if an application is installed on a device (Automated)
# 1. Find the EXACT name of the app you want to find on the device
# 2. Find the Bundle ID since the application name can change per device
# 3. Run script to check
# 4. YOU can copy output from Bundle ID & add it to the final script
#############################################################################################
# Find the Application Bundle ID
#############################################################################################

Application="Exact Application Name"
AppID=$(osascript -e "id of app \"$Application\"")

#############################################################################################
# Check if the App is installed via Bundle ID
#############################################################################################

if osascript -e "application id \"${AppID}\"" >/dev/null 2>&1; then
    echo "OK: $Application found"
else
    echo "ERROR: Cannot find $Application"
fi

#############################################################################################
# Full command here to check (Manually)
#
# if osascript -e 'application id "bundle_ID"' >/dev/null 2>&1; then
#     echo "Yes, Application available"
# else
#     echo "No, Application not found"
# fi
#############################################################################################