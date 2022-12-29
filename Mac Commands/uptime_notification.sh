days_up=$(uptime | awk '{print $3}')
message="Your Device has been up for ${days_up} day please restart to avoid any issues"
Title="Uptime"

# Alerts the user if device uptime is over specified date "Adjust the "

if [ "${days_up}" -gt "$(($(/bin/date +%D)-0))" ]
then
    result= osascript -e "display notification \"$message\" with title \"$Title\" sound name \"Purr\""
fi
exit 0