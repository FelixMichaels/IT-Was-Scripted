#!/bin/bash

######################################################################
# BASH menu script that checks:
#   - Device Insight
#   - Power Settings
#   - Max Disk Space 
#   - Keyboard
#	- Camera & Microphone
#	- Diagnostics
######################################################################

device_name=$(scutil --get ComputerName)
device_age=$(# variables

crntusr="$(/usr/bin/stat -f %Su /dev/console)"
plistsp="/Users/$crntusr/Library/Preferences/com.apple.SystemProfiler.plist"
srlnmbr="$(/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Serial/{print substr($NF,9)}')"


# if cpu is Apple Silicon collect Marketing Model string from ioreg
# if com.apple.SystemProfiler.plist does not exist create it
# if cpu is Intel collect Marketing Model string from com.apple.SystemProfiler.plist

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


# if that didn't work collect the Model Identifier, exit

if [ -z "$mrktmdl" ]
then
    echo "<result>$(/usr/sbin/sysctl -n hw.model)</result>"; exit
fi


# parse the Marketing Model string for the year

mdlyear="$(echo "$mrktmdl" | /usr/bin/sed 's/)//;s/(//;s/,//' | /usr/bin/grep -E -o '2[0-9]{3}')"


# compare year collected to year set as "too old" (setting to zero will return the year of the device)

if [ "$mdlyear" -lt "$(($(/bin/date +%Y)-0))" ]
then
    result="$mdlyear"
fi
echo "$mdlyear"
)

function device_insight() {
    echo ""
    echo "Device Insight for ${device_name} is: "
    echo""
    echo "
      Device year: ${device_age}"
    system_profiler SPHardwareDataType | grep -E -w 'Memory|Chip|Serial Number';
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
	echo "Total Disk Space for ${device_name}: "
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
	device_insight &> "${device_name}_device_check.txt"
	power_check >> "${device_name}_device_check.txt"
	disk_check >> "${device_name}_device_check.txt"
	echo "
	File exported as: ${device_name}_device_check.txt"
}

menu(){
echo -ne "
My First Menu
1) Device Info
2) Power Info
3) Disk Info
4) Check Keyboard
5) Check Camera & Mic
6) Export All Info
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