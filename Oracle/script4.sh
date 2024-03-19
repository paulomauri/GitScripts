#!/bin/bash
# Test Arithmetic Conditions

critVar=$(ps -ef | grep sqlplus | grep -v grep | wc -l)
if [ $critVar -lt 300 ]; then
	echo $critVar
	echo "Processes Running normal"
else
	echo "Too many processes"
	echo $critVar | mailx -s "Too many sqlplus procs" paulo.mauri@gmail.com
fi
exit 0  
