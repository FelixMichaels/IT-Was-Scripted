#########################################################################################################
# Stress Test Macbook
#########################################################################################################
# Created by Michael LeMay
#########################################################################################################
# Purpose
#########################################################################################################
# 
# This Script is used to run stress test on your device or multiple devices
# to verify that it can still preform under pressure.
#
#########################################################################################################
# Script version
VERSION="1.0"
############################################### Variables ###############################################

#checks the amount of cores a device has

Cores=$(sysctl -n hw.ncpu)
Core=$Cores

############################################### Logic ##################################################

#Stress test based off cores, then kill test after 30 seconds

echo "Stress Test Initiated, opening Activity Monitor"
sleep 3
open -a "Activity Monitor"

for Cores in $(seq $Core)
do
	yes > /dev/null &	

done

sleep 30
killall yes &> /dev/null
killall "Activity Monitor" &> /dev/null