### Setting up a Custom Dock ###


Method 1: Docutil

Pros: Allows the end user to add items to the Dock after removing and adding default applications
Cons: Does not lock the applications to the dock, end users can remove the apps as needed, provides the most flexibility. Also has the possibility to duplicate applications (icons only) if they are not installed prior to installation

How to Guide

Manually

* Download Docutil from Github https://github.com/kcrawford/dockutil/releases
* Install Docutil on your device/s of choice
* Create a script that will add and remove applications that you do not need or want
	* Script can be found above
* Adjust the script to have the applications that you want to be docked
* Place script on the target machine
* Place script on the target machine
	* Change the script permissions to be executable (chmod +x "Scriptname.sh")
	* Run the script to execute custom dock

Note: If docked applications are not on the machine it will show up as a question mark.
Note: If custom script for applications is the wrong path it will show up as a question mark.
Note: If application is downloaded after script is ran, it can cause a duplicate of the application in the dock.

Automated w/Kandji (Will be different w/other MDM)

* Download Docutil from Github https://github.com/kcrawford/dockutil/releases
* In Kandji
	* Navigate to Library > Add New > Custom Application
		* Name the Application: Docutil
		* Change the Image (Optional): https://tinyurl.com/542pz527
		* Assign Blueprint (Optional): Assign to your preferred blueprint
		* Rules (Optional): I like to utilize groups or Asset tags
			* Example #1: Google group NewHire MDM
			* Example #2: Asset tag New Hire (Asset tag must be set on machine)
		* Installation: Install Once or Install on deman Self service
			* Note: Install Once will install the PKG & Script in the order that Kandji sets
			* Note: Self service allows the most granular timing on when to set the doc
			* Note: If self service, you will need to adjust the self service settings to place the custom application in the category of your choice
		* Install details: Installer package (PKG, MPKG)
			* Upload PKG you downloaded above or from https://github.com/kcrawford/dockutil/releases
		* Expand Add Postinstall Script
			* Download example script above
				a. Adjust the script to have the applications that you want to be docked
			* Copy and paste the script into the script area
			* Save and continue

Method 2: Mobileconfig File

Pros: Easy to use and adjustable via Imazing profile Editor
Cons: Allows the user to add applications to the dock but after restart reverts back to the dock set by the default profile.

How to Guide
