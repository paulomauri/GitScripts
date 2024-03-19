#!/bin/bash
# Check ora Daemon processes

SID_LIST="ORCL"
critProc=ora_smon
for curSid in $SID_LIST
do
	ps -ef | grep -v 'grep' | grep ${critProc}_${curSid}
	if [ $? -eq 0 ]; then
		echo "$curSid is available."
	else
		echo "$curSid has issues" | mail -s "issue with $curSid" paulo.mauri@gmail.com
	fi
done
exit 0
