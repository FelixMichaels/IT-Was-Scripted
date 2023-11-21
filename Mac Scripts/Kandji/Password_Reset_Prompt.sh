#!/bin/bash

#########################################################################################################
# Macbook Password Reset Prompt
#########################################################################################################
# Created by Michael LeMay
#########################################################################################################
# Purpose
#########################################################################################################
# 
# This Script is used to force a password reset on a new device after issuing it w/temp password
# The goal is mostly to not rely on a new user to reset their password but to force it at 1st login  
#
#########################################################################################################
# Script version
VERSION="1.0"
######################################### Short Variables ###############################################
#Collects Current User and User ID
#########################################################################################################
CURRENT_USER=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" \
                | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }')
USER_ID=$(/usr/bin/id -u ${CURRENT_USER})

sudo pwpolicy -setpolicy -u "${CURRENT_USER}" "newPasswordRequired=1"

sleep 5

osascript -e 'ignoring application responses' -e 'tell application "loginwindow" to «event aevtrlgo»' -e end