#!/bin/bash

######################################################################
# BASH menu script that checks:
#   - Device Insight
#   - Power Settings
#   - Max Disk Space 
#   - Keyboard
#	- Camera & Microphone
######################################################################

device_name=$(hostname)

function device_insight() {
    echo ""
    echo "Device Insight for ${device_name} is: "
    echo""
    system_profiler SPHardwareDataType | grep -E -w 'Model Number|Model Identifier|Model Name|Memory|Chip|Serial Number'
    echo ""
}

function power_check() {
    echo ""
	echo "Power Settiings for ${device_name} are: "
    echo ""
	system_profiler SPPowerDataType | grep -E -w 'Cycle Count|Condition|Maximum Capacity'
    echo ""
}

function disk_check() {
    echo ""
	echo "Disk Space on ${device_name}: "
    echo ""
	system_profiler SPNVMeDataType | awk 'NR==9';
	system_profiler SPNVMeDataType | awk 'NR==7'
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
	device_insight
	power_check
	disk_check
}

menu(){
echo -ne "
My First Menu
1) Device Info
2) Power Info
3) Disk Info
4) Check Keyboard
5) Check Camera & Mic
6) Check All Info
0) Exit
Choose an option:"
        read a
        case $a in
	        1) device_insight ; menu ;;
	        2) power_check ; menu ;;
	        3) disk_check ; menu ;;
	        4) keyboard_check ; menu ;;
			5) cam_mic_check; menu ;;
	        6) all_checks ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}

# Call the menu function
menu