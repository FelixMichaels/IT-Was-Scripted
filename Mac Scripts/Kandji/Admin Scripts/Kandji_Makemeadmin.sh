#!/bin/bash
#########################################################################################################
# Kandji Macmeadmin
#########################################################################################################
# Created by https://github.com/jamf/MakeMeAnAdmin
# Updated by Michael LeMay Oct 19 2023
# Updated by Michael LeMay Nov 20 2023
#########################################################################################################
# Purpose
#########################################################################################################
# This Script promote and demote an account from standard to admin and back.
# It will also send a notification to the device on elevation and removal of access
# Additionally, sending updates to a slack channel for admin review and visibility
#########################################################################################################
# Script version
VERSION="1.0"
############################################### Variables ###############################################
# Update WEBHOOK_URL at line 20 & 141
minutes="30"
WEBHOOK_URL=""

############################################# NON - Editable Variables ##################################

set_time=$((minutes * 60))
Device_Name=$(scutil --get LocalHostName)
Serial_Number=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
Date=$(date -u '+%b %d, %I:%M:%S %p')
currentUser=$(stat -f%Su /dev/console)

############################################# PRE-CHECK ################################################
if /usr/sbin/dseditgroup -o checkmember -m $currentUser admin; then
    /usr/local/bin/kandji display-alert --title "Admin Access" --message "You already have administrative rights." --no-wait
else
############################################# SLACK WEBHOOK #############################################

# Function to send Slack message
send_slack_message() {
    local header_text=$1
    local body_text=$2

    curl -X POST -H 'Content-type: application/json' "${WEBHOOK_URL}" --data '{
    "blocks": [
        {
            "type": "header",
            "text": {
                "type": "plain_text",
                "text": "'"${header_text}"'",
                "emoji": true
            }
        },
        {
            "type": "divider"
        },
        {
            "type": "section",
            "fields": [
                {
                    "type": "mrkdwn",
                    "text": ">*Status: :unlock:*\n> '"${body_text}"'"
                },
                {
                    "type": "mrkdwn",
                    "text": ">*Time: :clock4:*\n> '"${Date}"' UTC"
                },
                {
                    "type": "mrkdwn",
                    "text": ">*Device Name: :computer:*\n> '"${Device_Name}"'"
                },
                {
                    "type": "mrkdwn",
                    "text": ">*Serial #: :1234:*\n> '"${Serial_Number}"'"
                }
            ],
            "accessory": {
                "type": "image",
                "image_url": "https://media0.giphy.com/media/bSEkPdQfsSHCMYn7fD/giphy.gif",
                "alt_text": "ah-hyuck!"
            }
        }
    ]
}'
}

###################################### SEND MESSAGE TO USER & SLACK ########################

send_grant_message() {
    /usr/local/bin/kandji display-alert --title "Admin Access" --message "You now have administrative rights for $minutes minutes. Please use your elevated permissions responsibly!" --no-wait
    send_slack_message "Admin Access Granted" "$currentUser has been granted admin access for $minutes minutes."
}

send_grant_message

#########################################################################################################
# write a daemon that will let you remove the privilege 
# with another script and chmod/chown to make           
# sure it'll run, then load the daemon                  
#########################################################################################################

# Create the plist
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist Label -string "removeAdmin"

# Add program argument to have it run the update script
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist ProgramArguments -array -string /bin/sh -string "/Library/Application Support/Kandji/removeAdminRights.sh"

# Set the run interval to run every 7 days
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist StartInterval -integer ${set_time}

# Set run at load
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist RunAtLoad -boolean yes

# Set ownership
sudo chown root:wheel /Library/LaunchDaemons/removeAdmin.plist
sudo chmod 644 /Library/LaunchDaemons/removeAdmin.plist

# Load the daemon
launchctl load /Library/LaunchDaemons/removeAdmin.plist
sleep 10

#########################################################################################################
# make file for removal #

rm -rf /private/var/userToRemove

mkdir /private/var/userToRemove
echo "$currentUser" >> /private/var/userToRemove/user

#########################################################################################################
# give the user admin privileges #

/usr/sbin/dseditgroup -o edit -a $currentUser -t user admin
fi
#########################################################################################################
# write a script for the launch daemon 
# to run to demote the user back and   
# then pull logs of what the user did. 
#########################################################################################################

cat << 'EOF' > /Library/Application\ Support/Kandji/removeAdminRights.sh
#!/bin/bash
############################################### Variables ###############################################
WEBHOOK_URL=""
Device_Name=$(scutil --get LocalHostName)
Serial_Number=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
Date=$(date -u '+%b %d, %I:%M:%S %p')

############################################# SLACK WEBHOOK #############################################
send_slack_message() {
    local header_text=$1
    local body_text=$2

    curl -X POST -H 'Content-type: application/json' "${WEBHOOK_URL}" --data '{
    "blocks": [
        {
            "type": "header",
            "text": {
                "type": "plain_text",
                "text": "'"${header_text}"'",
                "emoji": true
            }
        },
        {
            "type": "divider"
        },
        {
            "type": "section",
            "fields": [
                {
                    "type": "mrkdwn",
                    "text": ">*Status: :lock:*\n> '"${body_text}"'"
                },
                {
                    "type": "mrkdwn",
                    "text": ">*Time: :clock4:*\n> '"${Date}"' UTC"
                },
                {
                    "type": "mrkdwn",
                    "text": ">*Device Name: :computer:*\n> '"${Device_Name}"'"
                },
                {
                    "type": "mrkdwn",
                    "text": ">*Serial #: :1234:*\n> '"${Serial_Number}"'"
                }
            ],
            "accessory": {
                "type": "image",
                "image_url": "https://gifdb.com/images/high/mushroom-movie-punching-fight-5lsrgbxxlf41lbl3.gif",
                "alt_text": "ah-hyuck!"
            }
        }
    ]
}'
}

currentUser=$(stat -f%Su /dev/console)
############################################### Remove Admin #############################################

if [[ -f /private/var/userToRemove/user ]]; then
    userToRemove=$(cat /private/var/userToRemove/user)
    send_slack_message "Admin Access Removed" "$currentUser's admin access has been removed."
    /usr/local/bin/kandji display-alert --title "Admin Access" --message "Your Admin access has run out. You have now been reinstated back to your original permissions" --no-wait
    /usr/sbin/dseditgroup -o edit -d $userToRemove -t user admin
    rm -f /private/var/userToRemove/user
    launchctl unload /Library/LaunchDaemons/removeAdmin.plist
    rm /Library/LaunchDaemons/removeAdmin.plist
    
fi  
    exit 0
EOF