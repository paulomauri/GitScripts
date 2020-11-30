#!/bin/bash
# Test strings

checkUser=oracle
currentUser=$(whoami)
if [ "$currentUser" != "$checkUser" ]; then
	echo "You are current logged on as: $currentUser"
	echo "Must be logged on as $checkUser to run this script"
	exit 1
fi
echo "You are current logged as: $currentUser" 
exit 0
