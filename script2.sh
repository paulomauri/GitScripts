#!/bin/bash
# If condition

echo $ORACLE_SID
critProc=ora_smon
ps -ef | grep -v 'grep' | grep ${critProc}_$ORACLE_SID

if [ $? -eq 0 ]; then
	echo "SMON $ORACLE_SID is available."
else
	echo "SMON $ORACLE_SID has a issue." | mailx -s "issue with SMON $ORACLE_SID" paulo.mauri@gmail.com
fi
exit 0
