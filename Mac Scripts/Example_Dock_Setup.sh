#!/bin/bash
# NEW DockUtil Script without python v2.2

# Include Standard PATH for commands
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
# Set up variables
whoami="/usr/bin/whoami"
echo="/bin/echo"
sudo="/usr/bin/sudo"
dockutil="/usr/local/bin/dockutil"
killall="/usr/bin/killall"
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
LoggedInUserHome="/Users/$loggedInUser"
UserPlist=$LoggedInUserHome/Library/Preferences/com.apple.dock.plist

##########################################################################################
# Check if script is running as root
##########################################################################################
$echo

if [ `$whoami` != root ]; then
    $echo "[ERROR] This script must be run using sudo or as root. Exiting..."
    exit 1
fi

##########################################################################################
# Use Dockutil to Modify Logged-In User's Dock
##########################################################################################
$echo "----------------------------------------------------------------------"
$echo "Dockutil script to modify logged-in user's Dock"
$echo "----------------------------------------------------------------------"
$echo "Current logged-in user: $loggedInUser"
$echo "----------------------------------------------------------------------"
$echo "Removing all Items from the Logged-In User's Dock..."
$sudo -u $loggedInUser $dockutil --remove all --no-restart $UserPlist

$echo "Creating New Dock..."
$echo
$echo "Adding \"Finder\"..."

$echo "Adding \"Kandji Self Service\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Kandji Self Service.app" --no-restart $UserPlist

$echo "Adding \"Safari\"..."
$sudo -u $loggedInUser $dockutil --add "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app" --no-restart $UserPlist

$echo "Adding \"Google Chrome\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Google Chrome.app" --no-restart $UserPlist

$echo "Adding \"Slack\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Slack.app" --no-restart $UserPlist

$echo "Adding \"Calendar\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Calendar.app" --no-restart $UserPlist

$echo "Adding \"Notes\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Notes.app" --no-restart $UserPlist

$echo "Adding \"App Store\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/App Store.app" --no-restart $UserPlist

$echo "Adding \"System Settings\"..."
$sudo -u $loggedInUser $dockutil --add "/System/Applications/System Settings.app" --no-restart $UserPlist

$echo "Restarting Dock..."
$sudo -u $loggedInUser $killall Dock
exit 0