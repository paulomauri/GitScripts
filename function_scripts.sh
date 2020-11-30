#!/bin/bash
# Functions

debug=1
function showMsg {
	echo "----------------------------------------"
	echo "You're at location: $1 in the $0 script."
	echo "----------------------------------------"
} # showMsg
#
SID_LIST="ORCL"
critProc=ora_smon
#
if [[ debug -eq 1 ]]; then
	showMsg 1
fi
for curSid in $SID_LIST
do 
	ps -ef | grep -v 'grep' | grep ${critProc}_$curSid
	if [ $? -eq 0 ]; then
		echo "$curSid is available."
	else
		echo "$curSid has issues." | mailx -s "issue with $curSid" paulo.mauri@gmail.com
	fi
done
#
if [[ debug -eq 1 ]]; then
	showMsg 2
fi
#
exit 0
