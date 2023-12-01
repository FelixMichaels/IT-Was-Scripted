#!/bin/bash
#########################################################################################################
# Kandji MakeMeAnAdmin Remediation
#########################################################################################################
# Created by Michael LeMay Nov 23 2023 | Jones IT 
#########################################################################################################
# Purpose
#########################################################################################################
# This Script is used with the Kandji MakeMeAnAdmin script to Remediate Admins that should be standard users
# Place this script in the Remediation portion on your Custom Script in Kandji
#########################################################################################################
# Script version
VERSION="1.0"
############################################### Find Logged in User #####################################
CURRENT_USER=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" \ | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }')

############################################### Remove Admin Access #####################################
sudo /usr/sbin/dseditgroup -o edit -d $CURRENT_USER -t user admin
echo "Admin access has been removed"