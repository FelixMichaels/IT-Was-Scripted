#!/bin/bash
#########################################################################################################
# Kandji Uptime Notifier
#########################################################################################################
# Created by Michael LeMay
#########################################################################################################
# Purpose
#########################################################################################################
# 
# This Script will send an alert prompt to end users with a device
# that has been online longer than specified variable via Kandji Agent
#
#########################################################################################################
# Script version
VERSION="1.0"
############################################### Variables ###############################################

days_up=$(uptime | awk '{print $3}')
message="Your device has been up for ${days_up} days, please restart to avoid any issues!"
Title="Uptime Notifier"
uptime=$(uptime)

# Kandji output for a quick view, if you want to troubleshoot issues, because restarts fix alot

echo ${uptime}

# Alerts the user if device uptime is over specified date "Adjust the item -0, to + or - a specific #"
# If device is online less than 1 day will pull an error in logs, but this only applies to -0 time specified

if [ "${days_up}" -gt "$(($(/bin/date +%D)+14))" ]
then
    /usr/local/bin/kandji display-alert --title "$Title" --message "$message"
else
    echo "Device online less than defined amount"
fi > dev/null
exit 0