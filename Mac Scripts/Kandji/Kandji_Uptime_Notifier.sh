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
###################################### Variables ########################################################

days_up=$(uptime | awk '{print $3}')
stat=$(uptime | awk '{print $4}')
message="Your Device has been up for ${days_up} day(s) please restart to avoid any issues"
Title="Uptime"
uptime=$(uptime)
days="4"

# Kandji output for a quick view
echo "Current uptime is:" ${uptime}

# Skips any device online less than a day"
if ! [[ "${days_up}" =~ ^[0-9]+$ ]]
    then
        echo "device has been online for less than a day"
fi

if [ "${stat}" = "mins," ]
then
    echo "device has been online for less than a day"
    exit 0
fi

# Alerts the user if device uptime is over specified date "Adjust the item -0, to + or - a specific #"
# If device is online less than 1 day will pull an error in logs, but this only applies to -0 time specified​

if [ "${days_up}" -gt "${days}" ]
then
    /usr/local/bin/kandji display-alert --title "$Title" --message "$message"
fi > /dev/null
exit 0