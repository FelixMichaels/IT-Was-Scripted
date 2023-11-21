# Install Applications without installation variables

# Hashtable reference at bottom of the script
$appNameMapping = @{
    "7zip.7zip" = "7-Zip"
    "XPDP273C0XHQH2" = "Adobe Acrobat Reader DC"
    "9WZDNCRFJ3PZ" = "Company Portal"
    "Google.Chrome" = "Google Chrome"
    "Mozilla.Firefox" = "Mozilla Firefox"
    "PuTTY.PuTTY" = "PuTTY"
    "SlackTechnologies.Slack" = "Slack"
    "Splashtop.SplashtopBusiness" = "Splashtop Business"
    "9NBLGGH4VVNH" = "VLC UWP"
    "WinSCP.WinSCP" = "WinSCP"
}

$app_ids = "7zip.7zip", "XPDP273C0XHQH2", "9WZDNCRFJ3PZ", "Google.Chrome", "Mozilla.Firefox", "PuTTY.PuTTY", "SlackTechnologies.Slack", "Splashtop.SplashtopBusiness", "9NBLGGH4VVNH", "WinSCP.WinSCP"

foreach ($id in $app_ids) {
    # Check if the application ID exists in the mapping hashtable
    if ($appNameMapping.ContainsKey($id)) {
        $appName = $appNameMapping[$id]
        $output = winget install --id=$id -e --accept-package-agreements --accept-source-agreements --silent
        if ($output -match "No available upgrade found.") {
            Write-Host "$appName already installed on device"
        } elseif ($output -match "Available upgrade found.") {
            Write-Host "$appName upgrade available"
        } elseif ($output -match "Downloading") {
            Write-Host "$appName Downloaded"
        }
    } else {
        Write-Host "Application name not found for ID: $id"
    }
}

# Install Applications with variables

## Splashtop Streamer
winget install --id=Splashtop.SplashtopStreamer -e --accept-package-agreements --silent --override "prevercheck /s /i dcode=27454P54J7J3,confirm_d=0,hidewindow=1" | Out-Null

#############APP LIST REFERENCE ########################
# 7-Zip 19.00	          |	7zip.7zip
# Adobe Acrobat Reader DC |	XPDP273C0XHQH2
# Company Portal          |	9WZDNCRFJ3PZ
# Google Chrome 		  |	Google.Chrome	
# Mozilla Firefox		  |	Mozilla.Firefox
# PuTTY 				  |	PuTTY.PuTTY
# Slack 				  |	SlackTechnologies.Slack
# Splashtop Business 	  |	Splashtop.SplashtopBusiness	
# VLC UWP 				  | 9NBLGGH4VVNH
# WinSCP				  |	WinSCP.WinSCP
########################################################