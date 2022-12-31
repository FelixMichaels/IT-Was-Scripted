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

Core=$(sysctl -n hw.ncpu)

############################################### Logic ##################################################

#Stress test based off cores, then kill test after 30 seconds

echo "Stress Test Initiated, opening Activity Monitor"
sleep 3
open -a "Activity Monitor"

if  [ "${Core}" -eq 1 ]
then 
	yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 2 ]
then
	yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 3 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 4 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 5 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 6 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 7 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 8 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	pkill -9 -fx yes
fi &> /dev/null

if [ "${Core}" -eq 9 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 10 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 11 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

if [ "${Core}" -eq 12 ]
then
	yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null & yes > /dev/null &
	sleep 30
	killall yes
fi &> /dev/null

echo "Please confirm the information below"

#########################################################################################################
# QUESTIONS: 
# Did you hear any electrical or sizzling noises (Your CPU might be getting ready to take a dump)
# Did you hear any grinding or clicking in your fans (Consider getting a replacement fan soon)
# If you didnt hear or notice anything thenyour device is more than likely working in opitmal condition
#########################################################################################################


