############################
#Variables to Export to TXT
############################

DeviceName=$(scutil --get ComputerName)
HardwareData=$(system_profiler SPHardwareDataType | grep -E -w 'Memory|Chip|Serial Number|Processor Name')
PowerData=$(system_profiler SPPowerDataType | grep -E -w 'Cycle Count|Condition|Maximum Capacity|Full Charge Capacity')
NVMeData=$(system_profiler SPNVMeDataType | awk 'NR==9')
NVMeData2=$(system_profiler SPNVMeDataType | awk 'NR==7')
modelyear=$(

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

#Command Results in Application

echo "$mdlyear"
)

#Export Function

echo "${DeviceName}" &> Device_Check.txt
echo "Hardware Data:
${HardwareData},
      Device Year: ${modelyear}" >> Device_Check.txt
echo "Power Information:
${PowerData}" >> Device_Check.txt
echo "Harddrive space:
${NVMeData2}" >> Device_Check.txt

#Copy Export to Desktop

cp /Applications/BaselineCheck.app/Contents/Resources/Device_Check.txt ~/Desktop/"$DeviceName"_Device_Check.txt
echo "Export Successfull, file can be found in Desktop/"$DeviceName"_Device_Check.txt"