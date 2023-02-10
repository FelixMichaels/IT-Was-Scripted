Setting up a Custom Dock


Method 1: Docutil

Pros: Allows the end user to add items to the Dock after removing and adding default applications
Cons: Does not lock the applications to the dock, end users can remove the apps as needed, provides the most flexibility. Also has the possibility to duplicate applications (icons only) if they are not installed prior to installation

How to Guide

Manually

1. Download Docutil from Github https://github.com/kcrawford/dockutil/releases
2. Install Docutil on your device/s of choice
3. Create a script that will add and remove applications that you do not need or want
	3. My script can be found above
4. Adjust the script to have the applications that you want to be docked
5. Place script on the target machine
	a. Change the script permissions to be executable (chmod +x “Scriptname.sh)
	b. Run the script to execute custom dock

Note: If docked applications are not on the machine it will show up as a question mark.
Note: If custom script for applications is the wrong path it will show up as a question mark.
Note: If application is downloaded after script is ran, it can cause a duplicate of the application in the dock.

Automated w/Kandji (Will be different w/other MDM)

1. Download Docutil from Github https://github.com/kcrawford/dockutil/releases
2. In Kandji
	a. Navigate to Library > Add New > Custom Application
		i. Name the Application: Docutil
		ii. Change the Image (Optional): Image
		iii. Assign Blueprint (Optional): Assign to your preferred blueprint
		iv. Rules (Optional): I like to utilize groups or Asset tags
			1. Example #1: Google group NewHire MDM
			2. Example #2: Asset tag New Hire (Asset tag must be set on machine)
		v. Installation: Install Once or Install on deman Self service
			1. Note: Install Once will install the PKG & Script in the order that Kandji sets
			2. Note: Self service allows the most granular timing on when to set the doc
			3. Note: If self service, you will need to adjust the self service settings to place the custom application in the category of your choice
		vi. Install details: Installer package (PKG, MPKG)
			1. Upload PKG you downloaded above or from https://github.com/kcrawford/dockutil/releases
		vii. Expand Add Postinstall Script
			1. Download example script above
				a. Adjust the script to have the applications that you want to be docked
			2. Copy and paste the script into the script area
			3. Save and continue

Method 2: Mobileconfig File

Pros: Easy to use and adjustable via Imazing profile Editor
Cons: Allows the user to add applications to the dock but after restart reverts back to the dock set by the default profile.

How to Guide
