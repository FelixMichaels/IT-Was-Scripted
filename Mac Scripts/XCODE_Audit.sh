#!/bin/bash

#############################################################################################
# Created by Michael LeMay
#############################################################################################
if osascript -e 'application id "com.apple.dt.Xcode"' >/dev/null 2>&1; then
     echo "Application installed"
     exit 0
else
     echo "Application not found"
     exit 1
fi