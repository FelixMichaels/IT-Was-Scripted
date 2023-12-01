#!/bin/bash
#########################################################################################################
# Admin Checker
#########################################################################################################
# Created by Michael LeMay Nov 20 2023
#########################################################################################################
# Purpose
#########################################################################################################
# This Script will check if the current logged in user is an unapproved admin and demote
# Additionally, this works with the Kandji make me admin script
# https://github.com/FelixMichaels/IT-Was-Scripted/blob/master/Mac%20Commands/Kandji_Makemeadmin.sh
#########################################################################################################
# Script version
VERSION="1.0"
################################### Variables ###########################################################
exclude_admin=""

################################## Find Logged in User ##################################################
CURRENT_USER=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" \ 
				| /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }')

################################## User to Exclude ######################################################
if [ "${CURRENT_USER}" = "$exclude_admin" ]; then
    echo "${CURRENT_USER} is a permanent admin and excluded"
    exit 0
fi

################################## Check for Admin Escalation via Script ################################
if [ -f "/private/var/userToRemove/user" ]; then
    echo "Admin access currently given by Admin Escalation Script. Will check again tomorrow."
    exit 0
fi

################################## Check Admin Access ###################################################
if groups ${CURRENT_USER}| grep -q -w admin;
then 
echo "${CURRENT_USER} is currently an admin";
sudo /usr/sbin/dseditgroup -o edit -d $CURRENT_USER -t user admin
echo "Admin access has been removed"
exit 0 
else 
echo "${CURRENT_USER} is a standard user"; 
exit 0
fi

