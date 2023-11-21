#!/bin/bash

#########################################################################################################
# Macbook Baseline Checks
#########################################################################################################
# Created by Michael LeMay
#########################################################################################################
# Purpose
#########################################################################################################
# 
# This Script is used to check device health to determine re-usability
# BASH menu script that checks:
#   - Device Insight
#   - Power Settings
#   - Disk Space & Health
#   - Keyboard
#	- Camera & Microphone
#	
#
#########################################################################################################
# Script version
VERSION="1.0"
######################################### Short Variables ###############################################

device_name=$(scutil --get ComputerName)
hd_health=$(diskutil verifyDisk disk0 | grep -E -w 'The partition map appears to be')
cycle_count=$(system_profiler SPPowerDataType | awk '/Cycle Count/{printf "%s,", $3}' | tr "," " ")
cycle_used=$(awk -v x="${cycle_count}" -v y=1000 'BEGIN { print  ( x / y )*100 }')
total=$(awk -v a="${cycle_used}" -v b=100 'BEGIN { print  ( b - a ) }')


########################################### Long Variables ##############################################
#########################################################################################################
########################################### Device Age ##################################################
device_age=$(
crntusr="$(/usr/bin/stat -f %Su /dev/console)"
plistsp="/Users/$crntusr/Library/Preferences/com.apple.SystemProfiler.plist"
srlnmbr="$(/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Serial/{print substr($NF,9)}')"

if [ "$(/usr/sbin/sysctl -in hw.optional.arm64)" = 1 ] && /usr/sbin/sysctl -n machdep.cpu.brand_string | /usr/bin/grep -q 'Apple' && /usr/bin/uname -v | /usr/bin/grep -q 'ARM64'
then
    mrktmdl="$(/usr/libexec/PlistBuddy -c 'print 0:product-name' /dev/stdin <<< "$(/usr/sbin/ioreg -ar -k product-name)")"
else
    if ! [ -e "$plistsp" ]
    then
        /usr/bin/sudo -u "$crntusr" /usr/bin/open '/System/Library/CoreServices/Applications/About This Mac.app'; /bin/sleep 1
        /usr/bin/pkill -ail 'System Information'; /bin/sleep 1
        /usr/bin/killall cfprefsd; /bin/sleep 1
    fi
    mrktmdl="$(/usr/libexec/PlistBuddy -c "print 'CPU Names':$srlnmbr-en-US_US" "$plistsp" 2> /dev/null)"
fi

if [ -z "$mrktmdl" ]
then
    echo "<result>$(/usr/sbin/sysctl -n hw.model)</result>"; exit
fi

mdlyear="$(echo "$mrktmdl" | /usr/bin/sed 's/)//;s/(//;s/,//' | /usr/bin/grep -E -o '2[0-9]{3}')"

if [ "$mdlyear" -lt "$(($(/bin/date +%Y)-0))" ]
then
    result="$mdlyear"
fi
echo "$mdlyear"
)

########################################### Menu Functions ##############################################

function device_insight() {
    echo ""
    echo "Device Insight for ${device_name} is: "
    echo""
    echo "
      Device Year: ${device_age}"
    system_profiler SPHardwareDataType | grep -E -w 'Memory|Chip|Serial Number';
    echo ""
}

function power_check() {
    echo ""
	echo "Power Settings for ${device_name} are: "
    echo ""
    echo "
    	  "Cycle Capacity Remaining: ${total}"%"
	system_profiler SPPowerDataType | grep -E -w 'Cycle Count|Condition|Maximum Capacity'
    echo ""
}

function disk_check() {
    echo ""
	echo "Disk Health and Total Space for ${device_name}: "
    echo ""
    echo "
    	  Health: ${hd_health}"
	system_profiler SPNVMeDataType | awk 'NR==9';
	system_profiler SPNVMeDataType | awk 'NR==7';
    echo ""
}

function stress_check() {
    echo ""
	echo "Stress Test initiated on ${device_name}: "
    echo ""
    echo "
    	  This test will take 30 seconds:"
    echo ""
}

function keyboard_check() {
    echo ""
	echo "Opening up site to check keyboard on ${device_name}: "
	echo ""
	open https://keyboardchecker.com
    echo ""
}

function cam_mic_check() {
    echo ""
	echo "Opening up site to check keyboard on ${device_name}: "
	echo ""
	open https://webcammictest.com/ 
    echo ""
}
function all_checks() {
	device_insight &> "${device_name}_device_check.txt"
	power_check >> "${device_name}_device_check.txt"
	disk_check >> "${device_name}_device_check.txt"
	echo "
	File exported as: ${device_name}_device_check.txt"
}

########################################### Menu Prompt #################################################

menu(){
echo -ne "
My First Menu
1) Device Info
2) Power Info
3) Disk Info
4) Check Keyboard
5) Check Camera & Mic
6) CPU Stress Test
7) Export All Info
0) Exit
Choose an option:"
        read a
        case $a in
	        1) device_insight ; menu ;;
	        2) power_check ; menu ;;
	        3) disk_check ; menu ;;
	        4) keyboard_check ; menu ;;
			5) cam_mic_check; menu ;;
			6) stress_check; menu ;;
	        7) all_checks ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}

########################################## Call the Menu Function #######################################
menu