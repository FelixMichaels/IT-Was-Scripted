##########################################################################################################################
# Windows Baseline Security
# Author: Michael LeMay
# Verison: 1.0
# Updated: 13 Dec 2022
#
# Draft as of 20 Feb 2023
##########################################################################################################################

# DEACTIVATE THE BUILT IN WINDWOS ADMINISTRATOR ACCOUNT
net user administrator /active:no

# DEACTIVATE THE BUILT IN WINDWOS GUEST ACCOUNT
net user guest /active

###########################################################################################################################
# REMOVALABLE MEDIA BLOCKS IN REGISTRY
# EXAMPLE (New-ItemProperty -Path {REG KEY PATH} -Name '{Deny_Read,WRITE} -Value 1 -PropertyType 'DWord' -Force | Out-Null)
###########################################################################################################################

# Floppy Drives: Deny read access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Read -Value 1 -PropertyType 'DWord' -Force | Out-Null

# Floppy Drives: Deny write access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56311-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Write -Value 1 -PropertyType 'DWord' -Force | Out-Null

# CD and DVD: Deny read access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56308-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Read -Value 1 -PropertyType 'DWord' -Force | Out-Null

# CD and DVD: Deny write access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f56308-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Write -Value 1 -PropertyType 'DWord' -Force | Out-Null

# Removable Disks: Deny read access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Read -Value 1 -PropertyType 'DWord' -Force | Out-Null

# Removable Disks: Deny write access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Write -Value 1 -PropertyType 'DWord' -Force | Out-Null

# Tape Drives: Deny read access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Read -Value 1 -PropertyType 'DWord' -Force | Out-Null

# Tape Drives: Deny write access
New-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630b-b6bf-11d0-94f2-00a0c91efb8b} -Name 'Deny_Write -Value 1 -PropertyType 'DWord' -Force | Out-Null

##########################################################################################################################
# Disable File and Printer Sharing
##########################################################################################################################

#All Network Profiles
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Any

##########################################################################################################################
# Computer naming convention
##########################################################################################################################

#Get computer name and rename it
HOSTNAME= $(hostname)
CURRENT_USER= $(Get-LoggedOnUser -ComputerName {$hostname})

#rename device
Rename-Computer -NewName "Apollo - ${hostname}s Windows PC"


