#!/bin/bash
#########################################################################################################
# Kandji MakeMeAnAdmin Audit
#########################################################################################################
# Created by Michael LeMay Nov 23 2023 | Jones IT 
#########################################################################################################
# Purpose
#########################################################################################################
# This Script is used with the Kandji MakeMeAnAdmin script to Audit Admins that should be standard users
# Place this script in the Audit portion on your Custom Script in Kandji
#########################################################################################################
# Script version
VERSION="1.0"
############################################### Editable Variables ######################################
exclude_admin=("ksadmin" "michael")

############################################### Find Logged in User #####################################
CURRENT_USER=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" \ | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }')

############################################### User to Exclude #########################################
if [[ " ${exclude_admin[@]} " =~ " ${CURRENT_USER} " ]]; then
    echo "${CURRENT_USER} is a permanent admin and excluded"
    exit 0
fi

############################################### Check for userToRemove directory ########################
if [ -f "/private/var/userToRemove/user" ]; then
    echo "Admin access currently given by Admin Escalation Script."
    exit 0
fi

if groups ${CURRENT_USER}| grep -q -w admin; 
then 
echo "${CURRENT_USER} is currently an admin";
exit 1 
else 
echo "${CURRENT_USER} is a standard user"; 
exit 0
fi