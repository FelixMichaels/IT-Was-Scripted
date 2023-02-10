# Static App Repository #

### Used for iMazing ###

Type  | Label          | Display Name         | Type   | Path                                                                 | Path Type |
----- | -------------  | ------------         | -----  | ------------------------------------------------------------------   | --------- |
File  | Launchpad      | Launchpad            | File   | /System/Applications/Launchpad.app                                   | 0         |
File  | Self Service   | Kandji Self Service  | File   | /Applications/Kandji Self Service.app                                | 0         |
File  | Safari         | Safari               | File   | /System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app | 0         |
File  | Google Chrome  | Google Chrome        | File   | /Applications/Google Chrome.app                                      | 0         |
File  | Slack          | Slack                | File   | /Applications/Slack.app                                              | 0         |
File  | Dropbox        | Dropbox              | File   | /Applications/Dropbox.app                                            | 0         |
File  | Calendar       | Calendar             | File   | /System/Applications/Calendar.app                                    | 0         |
File  | Microsoft Excel| Microsoft Excel      | File   | /Applications/Microsoft Excel.app                                    | 0         |
File  | Microsoft Word | Microsoft Word       | File   | /Applications/Microsoft Word.app                                     | 0         |
File  | Notes          | Notes                | File   | /System/Applications/Notes.app                                       | 0         |
File  | App Store      | App Store            | File   | /System/Applications/App Store.app                                   | 0         |
File  | Preview        | Preview              | File   | /System/Applications/Preview.app                                     | 0         |
File  | System Settings| System Settings      | File   | System/Applications/System Settings.app                              | 0         |
File  | Content Cell   | Content Cell         | File   | Content Cell                                                         | 0         |
File  | Content Cell   | Content Cell         | File   | Content Cell                                                         | 0         |
File  | Content Cell   | Content Cell         | File   | Content Cell                                                         | 0         |
File  | Content Cell   | Content Cell         | File   | Content Cell                                                         | 0         |


### Used for Docutil ###

[Example_Dock_Setup.sh](https://github.com/FelixMichaels/SE-JIT/blob/master/Mac%20Commands/Custom%20Dock/Example_Dock_Setup.sh)

```shell
# Launchpad Application
$echo "Adding \"Launchpad\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Launchpad.app" --no-restart $UserPlist

# Kandji Self Service Application
$echo "Adding \"Kandji Self Service\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Kandji Self Service.app" --no-restart $UserPlist

# Safari Application
$echo "Adding \"Safari\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Safari.app" --no-restart $UserPlist

# Google Chrome Application
$echo "Adding \"Google Chrome\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Google Chrome.app" --no-restart $UserPlist

# Front Application
$echo "Adding \"Front\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Front.app" --no-restart $UserPlist

# Slack Application
$echo "Adding \"Slack\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Slack.app" --no-restart $UserPlist

# Basecamp 3 Application
$echo "Adding \"Basecamp 3\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Basecamp 3.app" --no-restart $UserPlist

# Dropbox Application
$echo "Adding \"Dropbox\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Dropbox.app" --no-restart $UserPlist

# 1Password 7 Application
$echo "Adding \"1Password 7\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/1Password 7.app" --no-restart $UserPlist

# Microsoft Excel Application
$echo "Adding \"Microsoft Excel\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Microsoft Excel.app" --no-restart $UserPlist

# Microsoft Word Application
$echo "Adding \"Microsoft Word\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Microsoft Word.app" --no-restart $UserPlist

# Calendar Application
$echo "Adding \"Calendar\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Calendar.app" --no-restart $UserPlist

# Notes Application
$echo "Adding \"Notes\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Notes.app" --no-restart $UserPlist

# App Store Application
$echo "Adding \"App Store\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/App Store.app" --no-restart $UserPlist

# Preview Application
$echo "Adding \"Preview\"..."
$sudo -u $loggedInUser $dockutil --add "/Applications/Preview.app" --no-restart $UserPlist

# System Setings Application
$echo "Adding \"System Settings\"..."
$sudo -u $loggedInUser $dockutil --add "/System/Applications/System Settings.app" --no-restart $UserPlist

# Documents Folder
$echo "Adding \"Documents\"..."
$sudo -u $loggedInUser $dockutil --add "~/Documents" --section others --view auto --display folder --no-restart $UserPlist

# Downloads Folder
$echo "Adding \"Downloads\"..."
$sudo -u $loggedInUser $dockutil --add "~/Downloads" --section others --view auto --display folder --no-restart $UserPlist
```