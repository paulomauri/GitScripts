#!/bin/bash
# Read command line

keeGoing=n
echo "Current value of ORACLE_SID: $ORACLE_SID"
echo -n "Do you want to continue? [y/n] "
read keepGoing
if [ "$keepGoing" = "y" ]; then
	echo "Continue run the script"
else
	echo "Exiting the script"
	exit 1
fi
exit 0

